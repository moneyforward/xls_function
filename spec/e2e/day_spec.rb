RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'DAY' do
    let(:input) { 'DAY(44591)' } # 2022/1/31

    it { is_expected.to eq(31) }

    context 'when cannot convert' do
      let(:input) { 'DAY("abc")' }

      it { is_expected.to be_error }
    end
  end
end
