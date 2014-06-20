require "queue_classic_admin/engine"
require "queue_classic_admin/custom_action"

module QueueClassicAdmin

  def self.custom_actions
    @@custom_actions ||= {}
  end

  def self.add_custom_action(name, &block)
    action = CustomAction.new(name, &block)
    custom_actions[action.slug] = action
  end
end

