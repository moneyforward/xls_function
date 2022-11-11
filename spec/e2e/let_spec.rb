RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'LET' do
    let(:input) { 'LET(hoge, "fuga", hoge = "fuga")' }

    it { is_expected.to eq(true) }
  end
end
