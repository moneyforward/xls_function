RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'LOWER' do
    let(:input) { 'LOWER("ABC")' }

    it { is_expected.to eq('abc') }
  end
end
