RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'NOT' do
    where(:cond1, :result) do
      [
        ['FALSE', true],
        ['TRUE', false],
        ['1 + 1 = 2', false],
        ['2 + 2 = 5', true]
      ]
    end

    with_them do
      let(:input) { "NOT(#{cond1})" }

      it { is_expected.to eq(result) }
    end
  end
end
