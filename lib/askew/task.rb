require 'date'
#require_relative './pattenhelpers.rb'

module Askew

  # @author David Askew
  class Task
    include Comparable
    include Askew::PatternHelpers

    @@today_date_string = "#{DateTime.now.year}-#{DateTime.now.month.to_s.rjust(2,'0')}-#{DateTime.now.day.to_s.rjust(2,'0')}"

    def self.today_date_string
      @@today_date_string
    end

    def initialize(line, options=Askew::Options.new)
      raise ArgumentError if line==nil
      raise ArgumentError if line.strip.empty?
      @raw = line
      @priority = extract_priority(raw)

      created = extract_created_on(raw)
      today = @@today_date_string 

      @created_on = created.nil? ? today : created
      @tags = extract_tags(raw)
      @contexts ||= extract_contexts(raw)
      @projects ||= extract_projects(raw)

      if options.require_completed_on
        @completed_on = extract_completed_date(raw)
        @is_completed = !@completed_on.nil?
      else
        @completed_on = extract_completed_date(raw)
        @is_completed = check_completed_flag(raw)
      end
    end

    # The raw line string from the tasklist file the task originates from.
    # @return [String] the raw text of the task.
    attr_reader :raw

    attr_reader :created_on

    attr_reader :completed_on

    attr_accessor :tags

    attr_accessor :priority
    
    attr_accessor :contexts

    attr_accessor :projects

    def text
      @text ||= extract_item_text(raw)
    end

    def text=(new_text)
      @text = new_text
    end

    def due_on
      begin
        Date.parse(tags[:due]) if tags[:due] =~ /(\d{4}-\d{2}-\d{2})/
      rescue ArgumentError
        return nil
      end
    end

    def overdue?
      !due_on.nil? && due_on < Date.today
    end

    def done?
      @is_completed
    end

    # Marks the task as done.
    #
    #
    def do!
      @completed_on = Date.today
      @is_completed = true
      @priority = nil
    end

    def undo!
      @completed_on = nil
      @is_completed = false
      @priority = extract_priority(raw)
    end

    def priority_inc!
      if @priority.nil?
        @priority = 'A'
      elsif @priority.ord > 65
        @priority = (@priority.ord - 1).chr
      end
      @priority
    end

    def priority_dec!
      return if @priority.nil?
      @priority = @priority.next if @priority.ord < 90
      @priority
    end

    def toggle!
      done? ? undo! : do!
    end

    def <=>(other)
      if priority.nil? && other.priority.nil?
        0
      elsif other.priority.nil?
        1
      elsif priority.nil?
        -1
      else
        other.priority <=> priority
      end
    end

    def to_s
      [
        print_done_marker,
        print_priority,
        created_on.to_s,
        text,
        print_contexts,
        print_projects,
        print_tags
      ].reject { |item| !item || item.nil? || item.empty? }.join(' ')
    end

    private

    def print_done_marker
      return unless done?

      if completed_on.nil?
        COMPLETED_FLAG
      else
        "#{COMPLETED_FLAG} #{completed_on}"
      end
    end

    def print_priority
      return unless priority

      "(#{priority})"
    end

    def print_contexts
      contexts.join(' ')
    end

    def print_projects
      projects.join(' ')
    end

    def print_tags
      tags.map { |tag, val| "#{tag}:#{val}" }.join(' ')
    end
  end
end
