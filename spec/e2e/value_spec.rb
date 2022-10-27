RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'VALUE' do
    let(:input) { 'VALUE("1,000")' }

    it { is_expected.to eq(1000) }

    context 'when number passed' do
      let(:input) { 'VALUE(1.1)' }

      it { is_expected.to eq(1.1) }
    end

    context 'when cannot convert' do
      let(:input) { 'VALUE("abc")' }

      it { is_expected.to be_error }
    end
  end
end
