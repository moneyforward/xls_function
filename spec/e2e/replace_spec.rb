RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'REPLACE' do
    let(:input) { 'REPLACE("abcdef", 3, 2, "zz")' }

    it { is_expected.to eq('abzzef') }
  end
end
