require_relative "../test_helper.rb"

class TaskListTest < Minitest::Test

  def setup
    @t1 = Askew::Task.new("(B) 1st raw task line +proj1 @con1 +project2 @context2")
    @t2 = Askew::Task.new("(A) 2nd raw task line +proj3 @con1 +project2 @context3")
    @h1 = { 1 => @t1, 2 => @t2 }
    @tl1 = Askew::TaskList.new @h1
  end

  def test_tasklist_can_be_created_from_path
    skip
    #fakefs setup first? 
  end

  def test_tasklist_can_be_created_from_hash_of_tasks
    assert_equal 2 , @tl1.size
  end

  def test_tasklist_has_list_of_projects
    assert_equal true, @tl1.projects.size > 0
    assert_equal Array, @tl1.projects.class
    #check contents of projects list?
  end

  def test_tasklist_has_list_of_contexts
    assert_equal true , @tl1.contexts.size > 0
    assert_equal Array, @tl1.contexts.class
    #check contents of contexts list?
  end

  def test_tasklist_can_be_searched
    tl1_results = @tl1.search '+proj1'
    assert_equal 1 , tl1_results.size

    tl1_results = @tl1.search '@con1'
    assert_equal 2, tl1_results.size

    assert_equal Askew::TaskList , tl1_results.class
  end

  def test_tasklist_can_be_subsetted_by_priority
    tl1_priority_A = @tl1.by_priority 'A'
    assert_equal 1, tl1_priority_A.size
  end

  def test_tasklist_can_be_subsetted_by_context
    con1_tasklist = @tl1.by_context "@con1"
    assert_equal 2, con1_tasklist.size
    con2_tasklist = @tl1.by_context "@context2"
    assert_equal 1, con2_tasklist.size
    assert_equal Askew::TaskList, con1_tasklist.class
  end

  def test_tasklist_can_be_subsetted_by_project
    p1_list = @tl1.by_project "+proj1"
    assert_equal 1, p1_list.size
    p2_list = @tl1.by_project "+project2"
    assert_equal 2, p2_list.size
    assert_equal Askew::TaskList, p1_list.class
  end

  def test_tasklist_can_be_subsetted_by_done
    skip
    #reimplementation of TaskList.by_done needed?
  end

  def test_tasklist_can_be_subsetted_by_not_done
    tl1_not_done = @tl1.by_not_done
    assert_equal Askew::TaskList, tl1_not_done.class
    assert_equal @tl1.size, tl1_not_done.size
  end

  def test_tasklist_can_remove_done_tasks_in_place
    @tl1[1].do!
    @tl1.remove_done!
    assert_equal 1 , @tl1.size
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
