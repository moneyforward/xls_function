RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'UPPER' do
    let(:input) { 'UPPER("abc")' }

    it { is_expected.to eq('ABC') }
  end
end
