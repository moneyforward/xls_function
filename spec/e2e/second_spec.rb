RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'SECOND' do
    let(:input) { 'SECOND("23:59:59")' }

    it { is_expected.to eq(59) }

    context 'when cannot convert' do
      let(:input) { 'SECOND("abc")' }

      it { is_expected.to be_error }
    end
  end
end
