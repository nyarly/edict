module Edict
  class Rule
    include Calibrate::Configurable
    include Calibrate::Configurable::DirectoryStructure

    def initialize
      setup_defaults
      yield self
      setup
    end

    def setup
    end

    def enact
      check_required # from Calibrate
      action
    end

    def action
    end
  end
end
