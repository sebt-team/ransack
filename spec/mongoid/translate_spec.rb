require 'mongoid_spec_helper'

module RansackMongo
  describe Translate do

    describe '.attribute' do
      it 'translate namespaced attribute like AR does' do
        ar_translation = ::Namespace::Article.human_attribute_name(:title)
        ransack_translation = RansackMongo::Translate.attribute(:title, :context => ::Namespace::Article.search.context)
        expect(ransack_translation).to eq ar_translation
      end
    end
  end
end
