RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'LEN' do
    let(:input) { 'LEN("abc")' }

    it { is_expected.to eq(3) }
  end
end
