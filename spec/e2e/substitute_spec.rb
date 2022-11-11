RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'SUBSTITUTE' do
    let(:source) { '"2021_12_17_15_28"' }

    context 'when occurrence number is not specified' do
      let(:input) { "SUBSTITUTE(#{source}, \"_\", \"/\")" }

      it { is_expected.to eq('2021/12/17/15/28') }
    end

    context 'When occurrence_number is specified' do
      let(:input) { "SUBSTITUTE(#{source}, \"_\", \"/\", #{occurrence_number})" }

      context 'occurrence_number is 1' do
        let(:occurrence_number) { '1' }

        it { is_expected.to eq('2021/12_17_15_28') }
      end

      context 'occurrence_number is 2' do
        let(:occurrence_number) { '2' }

        it { is_expected.to eq('2021_12/17_15_28') }
      end

      context 'occurrence_number is more than number of search_for count' do
        let(:occurrence_number) { '100' }

        it { is_expected.to eq('2021_12_17_15_28') }
      end

      context 'When occurrence_number is negative' do
        let(:occurrence_number) { '-1' }

        it { is_expected.to be_error }
      end
    end
  end
end
