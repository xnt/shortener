require 'rails_helper'

RSpec.describe Link, type: :model do

  describe '#original' do

    it { is_expected.to validate_presence_of(:original) }

    it { is_expected.to allow_value("http://google.com").for(:original) }
    it { is_expected.to allow_value("http://github.com/xnt").for(:original) }
    it { is_expected.to\
      allow_value("http://ruby-doc.org/stdlib-2.1.0/libdoc/uri/rdoc/URI/Parser.html")\
      .for(:original) }
    
    # Adding this because I was having some issues with the fake factory
    it { is_expected.to\
      allow_value("http://Pukwudgie.io/Nail/Roote+of+Lord+Harroway%27s+Town")\
      .for(:original) }

    it { is_expected.not_to allow_value("x").for(:original) }
    it { is_expected.not_to allow_value("<!-- dkajsflkas -->").for(:original) }
    it { is_expected.not_to allow_value("john@doe.net").for(:original) }
  end

  describe '#shortened' do
    it { is_expected.to validate_presence_of(:shortened) }
  end

  describe 'create_shortened' do

    it 'is not empty' do
      expect(Link::create_shortened).not_to be_empty
    end

    it 'is 8 characters long' do
      expect(Link::create_shortened.length).to eq(8)
    end
  end
end
