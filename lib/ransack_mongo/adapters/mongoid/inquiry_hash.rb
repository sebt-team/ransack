module RansackMongo
  module Adapters
    module Mongoid
      class InquiryHash < Hash

        def or(other)
          { '$or' => [ self, other] }.to_inquiry
        end

        def and(other)
          { '$and' => [ self, other] }.to_inquiry
        end

      end
    end
  end
end

class Hash
  def to_inquiry
    ::RansackMongo::Adapters::Mongoid::InquiryHash[self]
  end
end
