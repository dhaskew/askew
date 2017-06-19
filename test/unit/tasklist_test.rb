require_relative "../test_helper.rb"

class TaskListTest < Minitest::Test

  def setup
    @t1 = Askew::Task.new("1st raw task line +proj1 @con1 +project2 @context2")
    @t2 = Askew::Task.new("2nd raw task line +proj3 @con1 +project2 @context3")
    @h1 = { 1 => @t1, 2 => @t2 }
    @tl1 = Askew::TaskList.new @h1
  end

  def test_tasklist_can_be_created_from_path
    skip
    #fakefs setup first? 
  end

  def test_tasklist_can_be_created_from_hash_of_tasks
    assert_equal @tl1.size , 2 
  end

  def test_tasklist_has_list_of_projects
    assert_equal @tl1.projects.size > 0, true 
    #check contents of projects list
  end

  def test_tasklist_has_list_of_contexts
    skip 
  end

  def test_tasklist_can_be_searched
    skip 
  end

  def test_tasklist_can_be_sorted_by_priority
    skip 
  end

  def test_tasklist_can_be_subsetted_by_context
    skip 
  end

  def test_tasklist_can_be_subsetted_by_project
    skip 
  end

  def test_tasklist_can_be_subsetted_by_done
    skip
  end
  
  def test_tasklist_can_be_subsetted_by_not_done
    skip
  end

  def test_tasklist_can_purge_done_tasks_in_place
    skip 
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
