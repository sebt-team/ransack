require 'active_support/core_ext'
require 'ransack_mongo/configuration'
require 'ransack_mongo/adapters'

RansackMongo::Adapters.object_mapper.require_constants

module RansackMongo
  extend Configuration
  class UntraversableAssociationError < StandardError; end;

  SUPPORTS_ATTRIBUTE_ALIAS = false
end

RansackMongo.configure do |config|
  RansackMongo::Constants::AREL_PREDICATES.each do |name|
    config.add_predicate name, :arel_predicate => name
  end
  RansackMongo::Constants::DERIVED_PREDICATES.each do |args|
    config.add_predicate *args
  end
end

require 'ransack_mongo/search'
require 'ransack_mongo/ransacker'
require 'ransack_mongo/helpers'
require 'action_controller'
require 'ransack_mongo/translate'

RansackMongo::Adapters.object_mapper.require_adapter

ActionController::Base.helper RansackMongo::Helpers::FormHelper
