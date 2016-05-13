unless ::ActiveSupport::VERSION::STRING >= '4'
  describe 'RansackMongo' do
    it 'can be required without errors' do
      output = `bundle exec ruby -e "require 'ransack_mongo'" 2>&1`
      expect(output).to be_empty
    end
  end
end
