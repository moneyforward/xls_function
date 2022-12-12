RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'ABS' do
    where(:number, :result) do
      [
        [-8.9, 8.9],
        [9, 9]
      ]
    end

    with_them do
      let(:input) { "ABS(#{number})" }

      it { is_expected.to eq(result) }
    end
  end
end
