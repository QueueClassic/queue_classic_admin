require 'will_paginate'

module QueueClassicAdmin
  module JobCommon
    module ClassMethods
      KNOWN_COLUMN = ["id", "q_name", "method", "args", "locked_at", "created_at", "not_before"].freeze
      SEARCHABLE_COLUMNS = [ :method, :args ].freeze

      def queue_counts
        group(:q_name).count
      end

      def extra_columns
        columns.map(&:name) - KNOWN_COLUMN
      end

      def searchable_columns
        @searchable_columns ||= SEARCHABLE_COLUMNS.dup
      end

      def search(query)
        sql = searchable_columns.inject([]) do |sql, field|
          sql << "#{field} LIKE :query"
        end.join(" OR ")

        wildcard_query = ["%", query, "%"].join
        relation.where(sql, query: wildcard_query)
      end
    end

    module InstanceMethods
      def arguments
        if self.class.column_types["args"].type == :json
          args
        else
          MultiJson.decode(args)
        end
      end
    end

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, InstanceMethods
      receiver.attr_accessible :q_name unless defined?(ActionController::StrongParameters)
      receiver.per_page = 50 if receiver.respond_to?(:per_page)
    end
  end
end
