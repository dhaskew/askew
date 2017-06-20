require_relative "../test_helper.rb"

class TaskTest < Minitest::Test

  def setup
  end

  def test_tasks_can_be_created
    line = "simple task text"
    t1 = Askew::Task.new line
    assert_equal Askew::Task, t1.class
  end

  def test_tasks_can_have_priorities
    line = "(A) simple task with priority"
    t1 = Askew::Task.new line
    assert_equal "A", t1.priority
    line = "simple task without priority"
    t1 = Askew::Task.new line
    assert_nil t1.priority
  end

  def test_tasks_have_a_raw_line_value
    line ="(A) simple task with priority"
    t1 = Askew::Task.new line
    assert_equal line, t1.raw
  end

  def test_tasks_have_a_simple_text_value
    priority = "(A)"
    task_text = "simple task with priority"
    line = "#{priority} #{task_text}"
    t1 = Askew::Task.new line
    assert_equal task_text, t1.text
  end

  def test_tasks_get_a_created_on_date_if_they_dont_have_one
    line = "simple task"
    t1 = Askew::Task.new line
    refute_nil t1.created_on
  end

  def test_existing_tasks_can_have_a_created_on_date
    skip
  end

  def test_tasks_can_have_tags
    line = "simple task with tags foo:bar foobar:bazz"
    t1 = Askew::Task.new line
    refute_nil t1.tags
    assert_equal Hash, t1.tags.class
    assert_equal 2, t1.tags.size

    assert_equal t1.tags[:foo], 'bar'
    assert_equal t1.tags[:foobar], 'bazz'
  end

  def test_tasks_can_have_contexts
    line = "simple task with contexts @foo @bar"
    t1 = Askew::Task.new line
    refute_nil t1.contexts
    assert_equal 2, t1.contexts.size
    assert_equal Array, t1.contexts.class
    assert_includes t1.contexts, "@foo"
    assert_includes t1.contexts, "@bar"
  end

  def test_tasks_can_have_projects
    line = "simple task with projects +foo +bar"
    t1 = Askew::Task.new line
    refute_nil t1.projects
    assert_equal 2, t1.projects.size
    assert_equal Array, t1.projects.class
    assert_includes t1.projects, "+foo"
    assert_includes t1.projects, "+bar"
  end

  def test_tasks_can_be_completed
    skip
  end

  def test_completed_tasks_have_completion_dates
    skip
  end

  def test_tasks_can_be_done
    line = "simple task to do"
    t1 = Askew::Task.new line
    assert !t1.done?
    t1.do!
    assert t1.done?
  end

  def test_tasks_can_be_undone
    line = "simple task to do"
    t1 = Askew::Task.new line
    assert !t1.done?
    t1.do!
    assert t1.done?
    t1.undo!
    assert !t1.done?
    #how should priorities be handled?
  end

  def test_tasks_done_status_can_be_toggled
    line = "simple task to do"
    t1 = Askew::Task.new line
    assert !t1.done?
    t1.toggle!
    assert t1.done?
    t1.toggle!
    assert !t1.done?
  end

  def test_tasks_can_have_due_dates
    skip 
  end

  def test_tasks_can_be_overdue
    skip
  end
 
  def test_tasks_can_have_their_priority_increased
    line = "(B) simple task to do"
    t1 = Askew::Task.new line
    assert_equal "B", t1.priority
    t1.priority_inc!
    assert_equal "A", t1.priority
  end 

  def test_tasks_can_have_their_priority_decreased
    line = "(B) simple task to do"
    t1 = Askew::Task.new line
    assert_equal "B", t1.priority
    t1.priority_dec!
    assert_equal "C", t1.priority
  end 

end
