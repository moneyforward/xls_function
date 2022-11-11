RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'DATEVALUE' do
    let(:input) { 'DATEVALUE("2022/1/31 12:30:00")' }

    it { is_expected.to eq(44_591) }

    context 'when cannot convert' do
      let(:input) { 'DATEVALUE("abc")' }

      it { is_expected.to be_error }
    end
  end
end
