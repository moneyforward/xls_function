RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'YEAR' do
    let(:input) { 'YEAR(44591)' }

    it { is_expected.to eq(2022) }

    context 'when cannot convert' do
      let(:input) { 'YEAR("abc")' }

      it { is_expected.to be_error }
    end
  end
end
