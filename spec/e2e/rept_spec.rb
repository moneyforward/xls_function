RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'REPT' do
    let(:input) { "REPT(\"*-\", #{number})" }

    context 'when number is positive' do
      let(:number) { 3 }

      it { is_expected.to eq('*-*-*-') }
    end

    context 'when number is zero' do
      let(:number) { 0 }

      it { is_expected.to eq('') }
    end

    context 'when number is negative' do
      let(:number) { -1 }

      it { is_expected.to be_error }
    end
  end
end
