module Interface
  module Task
    def test_tasks_respond_to
      assert @task.respond_to?(:to_s)
      assert @task.respond_to?(:do!)
      assert @task.respond_to?(:undo!)
      assert @task.respond_to?(:done?)
      assert @task.respond_to?(:overdue?)
      assert @task.respond_to?(:due_on)
      assert @task.respond_to?(:toggle!)
      assert @task.respond_to?(:text)
      assert @task.respond_to?(:created_on)
      assert @task.respond_to?(:completed_on)
      assert @task.respond_to?(:tags)
      assert @task.respond_to?(:projects)
      assert @task.respond_to?(:contexts)
      assert @task.respond_to?(:<=>)
    end
  end
end
