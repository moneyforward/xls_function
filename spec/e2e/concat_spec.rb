RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'CONCAT' do
    let(:input) { 'CONCAT("abc", "abc")' }

    it { is_expected.to eq('abcabc') }
  end
end
