RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { string: 'a' } }
  let(:context) { nil }

  it { is_expected.to eq('a') }

  context 'when empty string' do
    let(:obj) { { string: [] } }

    it { is_expected.to eq('') }
  end
end
