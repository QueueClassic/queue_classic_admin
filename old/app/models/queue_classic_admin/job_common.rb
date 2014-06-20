module QueueClassicAdmin
  module JobCommon
    module ClassMethods
      KNOWN_COLUMN = ["id", "q_name", "method", "args", "locked_at", "created_at", "not_before"]
      def queue_counts
        group(:q_name).count
      end

      def extra_columns
        columns.map(&:name) - KNOWN_COLUMN
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
      receiver.attr_accessible :q_name unless defined?(ActionController::StrongParameters)
      receiver.per_page = 50
    end
  end
end
