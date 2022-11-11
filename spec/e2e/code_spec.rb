RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'CODE' do
    let(:input) { 'CODE("A")' }

    it { is_expected.to eq(65) }
  end
end
