RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'EXACT' do
    let(:input) { "EXACT(#{value_1}, #{value_2})" }

    let(:value_1) { '"abc"' }
    let(:value_2) { '"abc"' }

    it { is_expected.to eq(true) }

    context 'be falsy' do
      let(:value_2) { '"Abc"' }

      it { is_expected.to eq(false) }
    end
  end
end
