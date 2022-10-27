RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'EDATE' do
    let(:input) { "EDATE(#{date_value}, #{month})" }

    let(:date_value) { 44_591 }
    let(:month) { 1 }

    it { is_expected.to eq(44_619) }

    context 'second arg is negative' do
      let(:date_value) { 44_650 }
      let(:month) { -1 }

      it { is_expected.to eq(44_619) }
    end

    context 'cannot convert' do
      let(:date_value) { '"abc"' }

      it { is_expected.to be_error }
    end
  end
end
