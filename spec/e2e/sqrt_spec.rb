RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'SQRT' do
    where(:number, :result) do
      [
        [16, 4],
        [-16, '#NUM!']
      ]
    end

    with_them do
      let(:input) { "SQRT(#{number})" }

      it { is_expected.to eq(result) }
    end
  end
end
