module RansackMongo
  module Adapters

    def self.object_mapper
      @object_mapper ||= instantiate_object_mapper
    end

    def self.instantiate_object_mapper
      MongoidAdapter.new
      # ActiveRecordAdapter.new
    end

    class ActiveRecordAdapter
      def require_constants
        require 'ransack_mongo/adapters/active_record/ransack_mongo/constants'
      end

      def require_adapter
        require 'ransack_mongo/adapters/active_record/ransack_mongo/translate'
        require 'ransack_mongo/adapters/active_record'
      end

      def require_context
        require 'ransack_mongo/adapters/active_record/ransack_mongo/visitor'
      end

      def require_nodes
        require 'ransack_mongo/adapters/active_record/ransack_mongo/nodes/condition'
      end

      def require_search
        require 'ransack_mongo/adapters/active_record/ransack_mongo/context'
      end
    end

    class MongoidAdapter
      def require_constants
        require 'ransack_mongo/adapters/mongoid/ransack_mongo/constants'
      end

      def require_adapter
        require 'ransack_mongo/adapters/mongoid/ransack_mongo/translate'
        require 'ransack_mongo/adapters/mongoid'
      end

      def require_context
        require 'ransack_mongo/adapters/mongoid/ransack_mongo/visitor'
      end

      def require_nodes
        require 'ransack_mongo/adapters/mongoid/ransack_mongo/nodes/condition'
      end

      def require_search
        require 'ransack_mongo/adapters/mongoid/ransack_mongo/context'
      end
    end
  end
end
