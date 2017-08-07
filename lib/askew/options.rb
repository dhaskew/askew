module Askew

  class Options
    # Require all done tasks to have a `completed_on` date. True by default.
    #
    # - When `true`, tasks with invalid dates are considered not done.
    # - When `false`, tasks starting with `x ` are considered done.
    attr_accessor :require_completed_on

    def initialize
      reset
    end

    # Reset to defaults.
    def reset
      @require_completed_on = true
    end
  end
end
