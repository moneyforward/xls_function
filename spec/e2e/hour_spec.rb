RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'HOUR' do
    let(:input) { 'HOUR(0.5)' }

    it { is_expected.to eq(12) }

    context 'when cannot convert' do
      let(:input) { 'HOUR("abc")' }

      it { is_expected.to be_error }
    end
  end
end
