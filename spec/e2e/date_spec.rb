RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'DATE' do
    let(:input) { "DATE(#{year}, #{month}, #{day})" }

    let(:year) { 2022 }
    let(:month) { 1 }
    let(:day) { 1 }

    it { is_expected.to eq(44_561) }

    context 'month is invalid' do
      let(:month) { 0 }

      it { is_expected.to eq(44_530) }
    end

    context 'day is invalid' do
      let(:day) { 0 }

      it { is_expected.to eq(44_560) }
    end

    context 'year is invalid' do
      let(:year) { 10_000 }

      it { is_expected.to be_error }

      describe 'error_message is translated' do
        subject { described_class.evaluate(input).to_s }

        it { is_expected.to be_include('Value is out of range') }
      end
    end
  end
end
