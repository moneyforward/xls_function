RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'IF' do
    let(:input) { "IF(#{cond}, \"true\", \"false\")" }

    let(:cond) { '1 = 1' }

    it { is_expected.to eq('true') }

    context 'when cond returns false' do
      let(:cond) { '1 = 2' }

      it { is_expected.to eq('false') }
    end
  end
end
