RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { number: '1' }, operator: '=', right: right } }
  let(:context) { nil }

  let(:right) { { number: '1' } }

  it { is_expected.to eq(true) }

  context 'not equal' do
    let(:right) { { number: '2' } }

    it { is_expected.to eq(false) }
  end
end
