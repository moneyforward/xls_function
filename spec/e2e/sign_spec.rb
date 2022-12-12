RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'SIGN' do
    where(:number, :result) do
      [
        [-8.9, -1],
        [9, 1],
        [0.0, 0]
      ]
    end

    with_them do
      let(:input) { "SIGN(#{number})" }

      it { is_expected.to eq(result) }
    end
  end
end
