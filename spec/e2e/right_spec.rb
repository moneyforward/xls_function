RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'RIGHT' do
    let(:input) { 'RIGHT("abc", 2)' }

    it { is_expected.to eq('bc') }
  end
end
