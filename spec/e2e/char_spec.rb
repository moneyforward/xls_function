RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'CHAR' do
    where(:cond1, :result) do
      [
        ['65', 'A'],
        ['12354', '12354 out of char range']
      ]
    end

    with_them do
      let(:input) { "CHAR(#{cond1})" }

      it { is_expected.to eq(result) }
    end
  end
end
