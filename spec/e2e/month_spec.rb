RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'MONTH' do
    let(:input) { 'MONTH(44591)' }

    it { is_expected.to eq(1) }

    context 'when cannot convert' do
      let(:input) { 'MONTH("abc")' }

      it { is_expected.to be_error }
    end
  end
end
