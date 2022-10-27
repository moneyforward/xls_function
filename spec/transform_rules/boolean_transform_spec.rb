RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  describe 'True' do
    let(:obj) { { true_expr: 'TRUE' } }
    let(:context) { nil }

    it { is_expected.to eq(true) }
  end

  describe 'False' do
    let(:obj) { { false_expr: 'false' } }
    let(:context) { nil }

    it { is_expected.to eq(false) }
  end
end
