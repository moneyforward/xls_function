RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'ISNUMBER' do
    let(:input) { "ISNUMBER(#{value})" }

    let(:value) { '1' }

    it { is_expected.to eq(true) }

    context 'when value is not number' do
      let(:value) { '"1"' }

      it { is_expected.to eq(false) }
    end
  end
end
