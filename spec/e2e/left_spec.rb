RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'LEFT' do
    let(:input) { 'LEFT("abc", 2)' }

    it { is_expected.to eq('ab') }
  end
end
