RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { stub_slice(number: '1') }
  let(:context) { nil }

  it { is_expected.to eq(1) }
end
