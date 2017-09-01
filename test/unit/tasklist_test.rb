require_relative "../test_helper.rb"

class TaskListTest < Minitest::Test

  def setup
    @t1 = FactoryGirl.create :task,
                             :priority => "B",
                             :text => "1st raw task line",
                             :projects => ["+proj1", "+project2"],
                             :contexts => ["@con1", "@context2"]

    @t2 = FactoryGirl.create :task,
                             :priority => "A",
                             :text => "2nd raw task line",
                             :projects => ["+proj3", "+project2"],
                             :contexts => ["@con1", "@context3"]

    @h1 = { 1 => @t1, 2 => @t2 }
    @tasklist1 = FactoryGirl.create :tasklist, :tasks => @h1
    @default_size = 15
  end

  def test_tasklist_can_be_created_from_path
    tfile = File.expand_path('../../../test/inputs/tasks.txt', __FILE__)
    @tl2 = Askew::TaskList.new tfile
    assert_equal 4 , @tl2.size
  end

  def test_tasklist_can_be_created_from_hash_of_tasks
    assert_equal @tasklist1.size, @h1.size
    assert_equal @tasklist1.class, Askew::TaskList
  end

  def test_tasklist_has_list_of_projects
    assert_equal true, @tasklist1.projects.size > 0
    assert_equal Array, @tasklist1.projects.class
  end

  def test_tasklist_has_list_of_contexts
    assert_equal true , @tasklist1.contexts.size > 0
    assert_equal Array, @tasklist1.contexts.class
  end

  def test_tasklist_can_be_searched
    tl1_results = @tasklist1.search '+proj1'
    assert_equal 1 , tl1_results.size

    tl1_results = @tasklist1.search '@con1'
    assert_equal 2, tl1_results.size

    assert_equal Askew::TaskList , tl1_results.class
  end

  def test_tasklist_can_be_subsetted_by_priority
    tl1_priority_A = @tasklist1.by_priority 'A'
    assert_equal 1, tl1_priority_A.size
  end

  def test_tasklist_can_be_subsetted_by_context
    con1_tasklist = @tasklist1.by_context "@con1"
    assert_equal 2, con1_tasklist.size
    con2_tasklist = @tasklist1.by_context "@context2"
    assert_equal 1, con2_tasklist.size
    assert_equal Askew::TaskList, con1_tasklist.class
  end

  def test_tasklist_can_be_subsetted_by_project
    p1_list = @tasklist1.by_project "+proj1"
    assert_equal 1, p1_list.size
    p2_list = @tasklist1.by_project "+project2"
    assert_equal 2, p2_list.size
    assert_equal Askew::TaskList, p1_list.class
  end

  def test_tasklist_can_be_subsetted_by_done
    skip
    #reimplementation of TaskList.by_done needed?
  end

  def test_tasklist_can_be_subsetted_by_not_done
    tl1_not_done = @tasklist1.by_not_done
    assert_equal Askew::TaskList, tl1_not_done.class
    assert_equal @tasklist1.size, tl1_not_done.size
  end

  def test_tasklist_can_remove_done_tasks_in_place
    @tasklist1[1].do!
    @tasklist1.remove_done!
    assert_equal 1 , @tasklist1.size
  end

  def test_tasklist_can_archive_done_tasks
    skip
    #tasklists with no path?
  end

  def test_tasklist_can_save_to_path
    skip
    #tasklists with no path?
  end

  def test_tasklist_can_be_backed_up
    skip
    #tasklists with no path?
  end

end
