RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'IFS' do
    let(:input) { "IFS(#{cond1}, \"true1\", #{cond2}, \"true2\")" }

    let(:cond1) { '1 = 1' }
    let(:cond2) { '2 > 1' }

    it { is_expected.to eq('true1') }

    context 'when cond1 returns false' do
      let(:cond1) { '1 = 2' }

      it { is_expected.to eq('true2') }
    end
  end
end
