RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'PROPER' do
    where(:source, :result) do
      [
        ['"this is a TITLE"', 'This Is A Title'],
        ['"2-way street"', '2-Way Street'],
        ['"76BudGet"', '76Budget']
      ]
    end

    with_them do
      let(:input) { "PROPER(#{source})" }

      it { is_expected.to eq(result) }
    end
  end
end
