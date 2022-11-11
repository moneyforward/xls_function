RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'ROUNDUP' do
    where(:number, :num_digits, :result) do
      [
        [3.2, 0, 4],
        [76.9, 0, 77],
        [3.14159, 3, 3.142],
        [-3.14159, 1, -3.2],
        [31415.92654, -2, 31500]
      ]
    end

    with_them do
      let(:input) { "ROUNDUP(#{number}, #{num_digits})" }

      it { is_expected.to eq(result) }
    end
  end
end
