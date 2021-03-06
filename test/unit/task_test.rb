require_relative "../test_helper.rb"
require_relative "../interfaces.rb"

class TaskTest < Minitest::Test
  include Interface::Task

  def setup
    @task = FactoryGirl.create :task, :text => "simple task"
  end

  def test_tasks_cannot_be_created_from_a_nil_string
    assert_raises ArgumentError do
      task = Askew::Task.new(nil)
    end
  end

  def test_tasks_cannot_be_created_from_an_empty_string
    #empty string
    assert_raises ArgumentError do
      task = Askew::Task.new("")
    end
    #string of all whitespace
    assert_raises ArgumentError do
      task = Askew::Task.new("       ")
    end
  end

  def test_tasks_can_be_created
    task = FactoryGirl.create :task, :text => "foobar"
    assert_equal Askew::Task, task.class
  end

  def test_tasks_have_a_string_representation
    task = FactoryGirl.create :task, :text => "task string"
    refute_nil task.to_s
    assert task.to_s.include? "task string"
  end

  def test_tasks_can_be_created_with_priorities
    task = FactoryGirl.create :task, :priority => "A" , :text => "task string"
    refute_nil task.priority
    assert_equal task.priority , "A"
  end

  def test_tasks_have_a_raw_line_value
    task = FactoryGirl.create :task, :text => "text string"
    refute_nil task.raw
    assert task.raw.include? "text string"
  end

  def test_tasks_have_a_simple_text_value
    task_text = "simple task with priority"
    task = FactoryGirl.create :task, :text => task_text
    assert_equal task_text, task.text
  end

  def test_tasks_get_a_created_on_date_if_they_dont_have_one
    task = FactoryGirl.create :task, :text => "simple task string"
    refute_nil task.created_on
    assert_equal Askew::Task.today_date_string, task.created_on
  end

  def test_existing_tasks_can_have_a_created_on_date
    task = FactoryGirl.create :task, :created_today, :text => "task string"
    refute_nil task.created_on
    assert_equal Askew::Task.today_date_string, task.created_on.to_s
  end

  def test_tasks_can_have_tags
    task = FactoryGirl.create :task, :text => "task string", :tags => ["foo:bar", "foobar:bazz"]
    refute_nil task.tags
    assert_equal Hash, task.tags.class
    assert_equal 2, task.tags.size

    assert_equal task.tags[:foo], 'bar'
    assert_equal task.tags[:foobar], 'bazz'
  end

  def test_tasks_can_have_contexts
    task = FactoryGirl.create :task, :text => "task string", :contexts => ["@foo", "@bar"]
    refute_nil task.contexts
    assert_equal 2, task.contexts.size
    assert_equal Array, task.contexts.class
    assert_includes task.contexts, "@foo"
    assert_includes task.contexts, "@bar"
  end

  def test_tasks_can_have_projects
    task = FactoryGirl.create :task, :text => "task string", :projects => ["+foo", "+bar"]
    refute_nil task.projects
    assert_equal 2, task.projects.size
    assert_equal Array, task.projects.class
    assert_includes task.projects, "+foo"
    assert_includes task.projects, "+bar"
  end

  def test_completed_tasks_have_completion_dates
    task = FactoryGirl.create :task, :text => "simple task text"
    refute task.done?
    task.do!
    assert task.done?
    refute_nil task.completed_on
    assert task.to_s[0] == Askew::PatternHelpers::COMPLETED_FLAG
  end

  def test_completed_tasks_have_completion_markers
    task = FactoryGirl.create :task, :text => "simple task text"
    refute task.done?
    task.do!
    assert task.done?
    refute_nil task.completed_on
    assert task.to_s[0] == Askew::PatternHelpers::COMPLETED_FLAG
  end

  def test_tasks_can_be_done
    task = FactoryGirl.create :task, :text => "simple task to do"
    assert !task.done?
    task.do!
    assert task.done?
  end

  def test_tasks_can_be_undone
    task = FactoryGirl.create :task, :text => "simple task to do"
    assert !task.done?
    task.do!
    assert task.done?
    task.undo!
    assert !task.done?
  end

  def test_tasks_undone_have_priority_restored
    task = FactoryGirl.create :task, :text => "simple task", :priority => "A"
    assert task.priority == "A"
    task.do!
    assert task.done?
    task.undo!
    refute task.done?
    assert task.priority == "A"
  end

  def test_tasks_already_completed_may_have_a_completed_date_or_not
    #Options.require_completed_on = true

    task = FactoryGirl.create :task,
                              :created_today,
                              :require_completed_on => true,
                              :completion_marker => true,
                              :completed_on => Askew::Task.today_date_string,
                              :text => "simple task"
    assert task.done?
    assert_equal task.completed_on.to_s, Askew::Task.today_date_string

    #Options.require_completed_on = false
    task = FactoryGirl.create :task,
                              :created_today,
                              :require_completed_on => false,
                              :completion_marker => true,
                              :text => "simple task"
    assert task.done?
    assert_equal task.completed_on.to_s, Askew::Task.today_date_string
  end

  def test_tasks_with_completed_marker_and_no_complete_date
    skip

    # the test below should pass, but doesn't.
    # completion date is being picked up from creation date by mistake
    # how should a single date be parsed, if the completion marker is present?
    # - is it the completion date
    # - or is it the create date
    # - should that answer depened on the require_completed_on preference?
    # - should that even be a preference at this point?
    # - are these type scenarios better handled by tests on PatternHelpers module

    # without date
    task = FactoryGirl.create :task,
                              :created_today,
                              :require_completed_on => true,
                              :completion_marker => true,
                              :text => "simple task"
    refute task.done?
    assert_equal task.completed_on.to_s, Askew::Task.today_date_string

  end

  def test_tasks_can_be_compared
    high_pri = FactoryGirl.create :task, :text => "simple task", :priority => "A"
    low_pri = FactoryGirl.create :task, :text => "simple task", :priority => "Z"
    no_pri = FactoryGirl.create :task, :text => "simple task"
    no_pri2 = FactoryGirl.create :task, :text => "simple task"
    assert high_pri > low_pri
    assert low_pri > no_pri
    assert_equal no_pri, no_pri2
  end

  def test_tasks_done_status_can_be_toggled
    task = FactoryGirl.create :task, :text => "simple task to do"
    refute task.done?
    refute task.to_s[0] == Askew::PatternHelpers::COMPLETED_FLAG
    assert_nil task.completed_on
    task.toggle!
    assert task.done?
    assert task.to_s[0] == Askew::PatternHelpers::COMPLETED_FLAG
    refute_nil task.completed_on
    task.toggle!
    refute task.done?
    refute task.to_s[0] == Askew::PatternHelpers::COMPLETED_FLAG
    assert_nil task.completed_on
  end

  def test_tasks_can_have_due_dates
    line = "test task due:#{Date.today-1}"
    task = Askew::Task.new line
    refute_nil task.due_on
  end

  def test_tasks_can_be_overdue
    line = "test task due:#{Date.today-1}"
    task = Askew::Task.new line
    assert_equal true, task.overdue?
  end
 
  def test_tasks_can_have_their_priority_increased
    task = FactoryGirl.create :task, :text => "task string", :priority => "B"
    assert_equal "B", task.priority
    task.priority_inc!
    assert_equal "A", task.priority
  end 

  def test_tasks_can_have_their_nil_priority_increaded_to_default_value
    task = FactoryGirl.create :task, :text => "task text"
    assert_nil task.priority
    task.priority_inc!
    assert_equal "A", task.priority
  end

  def test_tasks_can_have_their_priority_decreased
    task = FactoryGirl.create :task, :text => "task text", :priority => "B"
    assert_equal "B", task.priority
    task.priority_dec!
    assert_equal "C", task.priority
  end

  def test_a_tasks_text_can_be_updated
    txt = "simple task"
    task = FactoryGirl.create :task, :text => txt
    assert_equal task.text, txt
    txt = "updated simple task"
    task.text = txt
    assert_equal task.text, txt
  end

end
