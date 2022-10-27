RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { string: 'abc' }, operator: '&', right: { string: 'def' } } }
  let(:context) { nil }

  it { is_expected.to eq('abcdef') }
end
