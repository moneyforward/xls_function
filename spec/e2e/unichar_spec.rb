RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'UNICHAR' do
    let(:input) { 'UNICHAR(66)' }

    it { is_expected.to eq('B') }
  end
end
