RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'SWITCH' do
    context 'when there is a result corresponding to the matching value' do
      let(:input) { 'SWITCH("abc", "abc", "match", "not match")' }

      it { is_expected.to eq('match') }
    end

    context 'when none match' do
      let(:input) { 'SWITCH("abc", "zzz", "match", "not match")' }

      it { is_expected.to eq('not match') }
    end

    context 'when there are no matches and no default arguments are specified' do
      let(:input) { 'SWITCH("abc", "zzz", "match")' }

      it { is_expected.to eq('#N/A') }
    end

    context 'when there are more than 126 arguments' do
      let(:input) { 'SWITCH("abc", ' + (1..127).map { |i| "\"#{i}\", \"match\"" }.join(', ') + ', "not match")' }

      it { is_expected.to eq('#N/A') }
    end
  end
end
