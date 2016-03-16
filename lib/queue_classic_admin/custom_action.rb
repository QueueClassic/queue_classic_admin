module QueueClassicAdmin
  class CustomAction
    attr_reader :name, :action

    def initialize(name, &block)
      @name, @action = name, block
    end

    def slug
      name.underscore
    end
  end
end
