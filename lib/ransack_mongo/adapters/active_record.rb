require 'ransack_mongo/adapters/active_record/base'
ActiveRecord::Base.extend RansackMongo::Adapters::ActiveRecord::Base

require 'ransack_mongo/adapters/active_record/context'

case ActiveRecord::VERSION::STRING
when /^3\.0\./
  require 'ransack_mongo/adapters/active_record/3.0/context'
when /^3\.1\./
  require 'ransack_mongo/adapters/active_record/3.1/context'
when /^3\.2\./
  require 'ransack_mongo/adapters/active_record/3.2/context'
end
