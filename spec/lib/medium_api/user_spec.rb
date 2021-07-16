# frozen_string_literal: true

require 'spec_helper'

RSpec.describe MediumApi::User do
  describe '#publications' do
    around { |e| VCR.use_cassette('my_publications', &e) }

    let(:api) { MediumApi.new(api_key: '2ada46c383ae76af4ca4dcbe42f7611062644f366bd6281c2efe78202b35f3c60') }

    subject(:me) { api.me }

    specify do
      expect(me.publications.size).to eq(1)
    end
  end
end
