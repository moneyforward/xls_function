RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { number: '2' }, operator: '*', right: { number: '2' } } }
  let(:context) { nil }

  it { is_expected.to eq(4) }
end
