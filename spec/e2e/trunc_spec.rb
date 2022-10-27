RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'TRUNC' do
    where(:number, :result) do
      [
        [8.9, 8],
        [-8.9, -8],
        [0.45, 0]
      ]
    end

    with_them do
      let(:input) { "TRUNC(#{number})" }

      it { is_expected.to eq(result) }
    end
  end
end
