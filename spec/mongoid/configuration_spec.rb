require 'mongoid_spec_helper'

module RansackMongo
  describe Configuration do
    it 'yields RansackMongo on configure' do
      RansackMongo.configure { |config| expect(config).to eq RansackMongo }
    end

    it 'adds predicates' do
      RansackMongo.configure do |config|
        config.add_predicate :test_predicate
      end

      expect(RansackMongo.predicates).to have_key 'test_predicate'
      expect(RansackMongo.predicates).to have_key 'test_predicate_any'
      expect(RansackMongo.predicates).to have_key 'test_predicate_all'
    end

    it 'avoids creating compound predicates if compounds: false' do
      RansackMongo.configure do |config|
        config.add_predicate(
          :test_predicate_without_compound,
          :compounds => false
          )
      end
      expect(RansackMongo.predicates)
      .to have_key 'test_predicate_without_compound'
      expect(RansackMongo.predicates)
      .not_to have_key 'test_predicate_without_compound_any'
      expect(RansackMongo.predicates)
      .not_to have_key 'test_predicate_without_compound_all'
    end

    it 'should have default value for search key' do
      expect(RansackMongo.options[:search_key]).to eq :q
    end

    it 'changes default search key parameter' do
      # store original state so we can restore it later
      before = RansackMongo.options.clone

      RansackMongo.configure do |config|
        config.search_key = :query
      end

      expect(RansackMongo.options[:search_key]).to eq :query

      # restore original state so we don't break other tests
      RansackMongo.options = before
    end

    it 'adds predicates that take arrays, overriding compounds' do
      RansackMongo.configure do |config|
        config.add_predicate(
          :test_array_predicate,
          :wants_array => true,
          :compounds => true
          )
      end

      expect(RansackMongo.predicates['test_array_predicate'].wants_array).to eq true
      expect(RansackMongo.predicates).not_to have_key 'test_array_predicate_any'
      expect(RansackMongo.predicates).not_to have_key 'test_array_predicate_all'
    end

    describe '`wants_array` option takes precedence over Arel predicate' do
      it 'implicitly wants an array for in/not in predicates' do
        RansackMongo.configure do |config|
          config.add_predicate(
            :test_in_predicate,
            :arel_predicate => 'in'
          )
          config.add_predicate(
            :test_not_in_predicate,
            :arel_predicate => 'not_in'
          )
        end

        expect(RansackMongo.predicates['test_in_predicate'].wants_array).to eq true
        expect(RansackMongo.predicates['test_not_in_predicate'].wants_array).to eq true
      end

      it 'explicitly does not want array for in/not_in predicates' do
        RansackMongo.configure do |config|
          config.add_predicate(
            :test_in_predicate_no_array,
            :arel_predicate => 'in',
            :wants_array => false
          )
          config.add_predicate(
            :test_not_in_predicate_no_array,
            :arel_predicate => 'not_in',
            :wants_array => false
          )
        end

        expect(RansackMongo.predicates['test_in_predicate_no_array'].wants_array).to eq false
        expect(RansackMongo.predicates['test_not_in_predicate_no_array'].wants_array).to eq false
      end
    end
  end
end
