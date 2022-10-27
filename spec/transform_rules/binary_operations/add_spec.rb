RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { number: '1' }, operator: '+', right: { number: '2' } } }
  let(:context) { nil }

  it { is_expected.to eq(3) }
end
