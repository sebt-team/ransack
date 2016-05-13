require 'ransack_mongo/adapters/mongoid/base'
::Mongoid::Document.send :include, RansackMongo::Adapters::Mongoid::Base

require 'ransack_mongo/adapters/mongoid/attributes/attribute'
require 'ransack_mongo/adapters/mongoid/table'
require 'ransack_mongo/adapters/mongoid/inquiry_hash'

case ::Mongoid::VERSION
when /^3\.2\./
  require 'ransack_mongo/adapters/mongoid/3.2/context'
else
  require 'ransack_mongo/adapters/mongoid/context'
end
