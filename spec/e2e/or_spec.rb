RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'OR' do
    where(:cond1, :cond2, :result) do
      [
        ['1 = 1', '2 = 2', true],
        ['1 = 2', '2 = 2', true],
        ['1 = 2', '2 = 1', false]
      ]
    end

    with_them do
      let(:input) { "OR(#{cond1}, #{cond2})" }

      it { is_expected.to eq(result) }
    end
  end
end
