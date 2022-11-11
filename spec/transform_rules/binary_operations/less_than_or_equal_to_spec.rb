RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { left: { number: '10' }, operator: '>=', right: right } }
  let(:context) { nil }

  let(:right) { { number: '10' } }

  it { is_expected.to eq(true) }

  context 'not less than' do
    let(:right) { { number: '11' } }

    it { is_expected.to eq(false) }
  end
end
