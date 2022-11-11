RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'AND' do
    where(:cond1, :cond2, :result) do
      [
        ['10 > 9', '1 = 1', true],
        ['10 < 9', '1 = 1', false],
        ['10 < 9', '"abc"', false]
      ]
    end

    with_them do
      let(:input) { "AND(#{cond1}, #{cond2})" }

      it { is_expected.to eq(result) }
    end
  end
end
