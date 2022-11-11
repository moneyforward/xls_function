RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'MINUTE' do
    let(:input) { 'MINUTE("9:30")' }

    it { is_expected.to eq(30) }

    context 'when cannot convert' do
      let(:input) { 'MINUTE("abc")' }

      it { is_expected.to be_error }
    end
  end
end
