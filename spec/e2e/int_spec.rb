RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'INT' do
    where(:number, :result) do
      [
        [8.9, 8],
        [-8.9, -9]
      ]
    end

    with_them do
      let(:input) { "INT(#{number})" }

      it { is_expected.to eq(result) }
    end
  end
end
