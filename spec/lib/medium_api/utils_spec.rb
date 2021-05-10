# frozen_string_literal: true

require 'medium_api/utils'

RSpec.describe MediumApi::Utils do
  describe 'underscore_keys' do
    let(:object) do
      {
        imageUrl: 'something',
        publicationId: '123',
        already_underscored: '123'
      }
    end

    let(:expected_object) do
      {
        image_url: 'something',
        publication_id: '123',
        already_underscored: '123'
      }
    end

    it 'underscores correctly' do
      expect(described_class.underscore_keys(object)).to eq(expected_object)
    end
  end

    describe 'camelize_keys' do
    let(:object) do
      {
        imageUrl: 'something',
        publication_id: '123'

      }
    end

    let(:expected_object) do
      {
        imageUrl: 'something',
        publicationId: '123'
      }
    end

    it 'underscores correctly' do
      expect(described_class.camelize_keys(object)).to eq(expected_object)
    end
  end
end
