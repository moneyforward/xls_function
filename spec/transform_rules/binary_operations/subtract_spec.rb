RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { number: '10' }, operator: '-', right: { number: '9' } } }
  let(:context) { nil }

  it { is_expected.to eq(1) }
end
