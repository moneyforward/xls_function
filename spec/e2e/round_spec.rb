RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'ROUND' do
    let(:input) { "ROUND(#{number}, #{num_digits})" }

    let(:number) { 25.123 }

    context 'num_digits is positive' do
      let(:num_digits) { 1 }

      it { is_expected.to eq(25.1) }
    end

    context 'num_digits is zero' do
      let(:num_digits) { 0 }

      it { is_expected.to eq(25) }
    end

    context 'num_digits is negative' do
      let(:num_digits) { -1 }

      it { is_expected.to eq(30) }
    end
  end
end
