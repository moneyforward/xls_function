RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'POWER' do
    where(:number, :power, :result) do
      [
        [5, 2, 25],
        [98.6, 3.2, 2401077.222]
      ]
    end

    with_them do
      let(:input) { "POWER(#{number}, #{power})" }

      it { expect(fixed_digit_round(subject)).to eq(result) }
    end
  end

  describe '^' do
    let(:input) { '5 ^ 2' }

    it { is_expected.to eq(25) }
  end
end
