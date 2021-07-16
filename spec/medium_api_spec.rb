require 'spec_helper'

RSpec.describe MediumApi do
  it "has a version number" do
    expect(MediumApi::VERSION).not_to be nil
  end

  let(:api_key) { '2ada46c383ae76af4ca4dcbe42f7611062644f366bd6281c2efe78202b35f3c60' }
  subject(:api) { described_class.new(api_key: api_key) }

  describe '#me' do
    around { |e| VCR.use_cassette('me', &e) }

    specify do
      expect(api.me.name).to eq('Test Api Key')
    end
  end

  describe '#user_publications' do
    around { |e| VCR.use_cassette('my_publications', &e) }

    let(:user_id) { "1b619f0be1bc842ffc55e8a20c7d6c9129ba896467b90ab9e23b86a36fdd2a67e" }

    specify do
      expect(api.user_publications(user_id: user_id).size).to eq(1)
    end
  end
end
