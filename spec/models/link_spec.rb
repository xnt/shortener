require 'rails_helper'

RSpec.describe Link, type: :model do

  describe '#original' do

    it { is_expected.to validate_presence_of(:original) }

    it { is_expected.to allow_value("http://google.com").for(:original) }
    it { is_expected.to allow_value("http://github.com/xnt").for(:original) }
    it { is_expected.to \
      allow_value("http://ruby-doc.org/stdlib-2.1.0/libdoc/uri/rdoc/URI/Parser.html")\
      .for(:original) }

    it { is_expected.not_to allow_value("x").for(:original) }
    it { is_expected.not_to allow_value("john@doe.net").for(:original) }
  end

  describe '#shortened' do
    it { is_expected.to validate_presence_of(:shortened) }
  end
end
