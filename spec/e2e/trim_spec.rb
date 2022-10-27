RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'TRIM' do
    let(:input) { 'TRIM(" a   b　 c　　　")' }

    it { is_expected.to eq('a b　c') }
  end
end
