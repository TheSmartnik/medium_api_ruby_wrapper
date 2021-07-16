# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MediumApi::Client do
  let(:api_key) { '2ada46c383ae76af4ca4dcbe42f7611062644f366bd6281c2efe78202b35f3c60' }
  let(:my_id) { '1b619f0be1bc842ffc55e8a20c7d6c9129ba896467b90ab9e23b86a36fdd2a67e' }

  subject(:client) { described_class.new(api_key: api_key) }

  describe '#me' do
    context 'with api_key' do
      around { |e| VCR.use_cassette('me', &e) }

      specify do
        me = client.me
        expect(me['id']).to eq(my_id)
        expect(me['name']).to eq('Test Api Key')
      end
    end

    context 'without api_key' do
      around { |e| VCR.use_cassette('me_without_api_key', &e) }
      let(:api_key) { '' }

      specify do
        expect { client.me }.to raise_error { MediumApi::Errors::UnauthorizedError }
      end
    end
  end

  describe '#publication_contributors' do
    around { |e| VCR.use_cassette('publication_contributors', &e) }

    specify do
      expect(client.publication_contributors('eca1ba5ae1ca').size).to eq(1030)
    end
  end


  describe '#create_user_post' do
    around { |e| VCR.use_cassette('create_user_post', &e) }

    specify do
      post_attributes = { title: "My First Post", content_format: "markdown", content: "# My First Post\n## I created this post via API" }

      created_post = client.create_user_post(my_id, post_attributes)
      expect(created_post['id']).to_not eq('')
      expect(created_post['title']).to eq('My First Post')
    end
  end
end
