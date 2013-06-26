module QueueClassicAdmin
  module JobCommon
    module ClassMethods
      def queue_counts
        group(:q_name).count
      end
    end
  
    module InstanceMethods
      def arguments
        JSON.parse(args)
      end
    end
  
    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end
