RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'TIMEVAULE' do
    let(:input) { 'TIMEVALUE("12:00:00")' }

    it { is_expected.to eq(0.5) }

    context 'when elapsed hour' do
      let(:input) { 'TIMEVALUE("36:00:00")' }

      it { is_expected.to eq(0.5)}
    end

    context 'when cannot convert' do
      let(:input) { 'TIMEVALUE("abc")' }

      it { is_expected.to be_error }
    end
  end
end
