RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'ISERROR' do
    let(:input) { "ISERROR(#{value})" }

    let(:value) { '"abc"' }

    it { is_expected.to eq(false) }

    context 'when value is error' do
      let(:value) { 'VALUE("abc")' }

      it { is_expected.to eq(true) }
    end
  end
end
