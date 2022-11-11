RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'FIXED' do
    let(:input) { "FIXED(#{number}, #{digit})" }

    let(:number) { '1234.567' }
    let(:digit) { '1' }

    it { is_expected.to eq('1,234.6') }

    context 'when not separate with comma' do
      let(:input) { "FIXED(#{number}, #{digit}, true)" }

      let(:number) { '-1234.567' }
      let(:digit) { '-1' }

      it { is_expected.to eq('-1230') }
    end
  end
end
