RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'ROUNDDOWN' do
    where(:number, :num_digits, :result) do
      [
        [3.2, 0, 3],
        [76.9, 0, 76],
        [3.14159, 3, 3.141],
        [-3.14159, 1, -3.1],
        [31415.92654, -2, 31400]
      ]
    end

    with_them do
      let(:input) { "ROUNDDOWN(#{number}, #{num_digits})" }

      it { is_expected.to eq(result) }
    end
  end
end
