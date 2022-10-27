RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'MID' do
    let(:input) { 'MID("abc", 2, 2)' }

    it { is_expected.to eq('bc') }
  end
end
