RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { number: '2' }, operator: '^', right: { number: '3' } } }
  let(:context) { nil }

  it { is_expected.to eq(8) }
end
