# frozen_string_literal: true
require 'spec_helper'

RSpec.describe MediumApi::Publication do
  let(:api) { MediumApi.new(api_key: '2ada46c383ae76af4ca4dcbe42f7611062644f366bd6281c2efe78202b35f3c60') }

  subject(:me) { api.me }

  describe '#contributors' do
    around { |e| VCR.use_cassette('my_publication_contributors', &e) }

    subject(:client) { described_class.new(api_key: api_key) }

    specify do
      expect(api.me.publications.first.contributors.size).to_not eq(0)
    end
  end
end
