module Askew

  class Options
    # Require all done tasks to have a `completed_on` date. True by default.
    #
    # - When `true`, tasks with invalid dates are considered not done.
    # - When `false`, tasks starting with `x ` are considered done.
    attr_accessor :require_completed_on

    # Whether or not to preserve original field order for roundtripping.
    attr_accessor :maintain_field_order

    def initialize
      reset
    end

    # Reset to defaults.
    def reset
      @require_completed_on = true
      @maintain_field_order = false
    end
  end
end