RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'UNICODE' do
    let(:input) { 'UNICODE("B")' }

    it { is_expected.to eq(66) }
  end
end
