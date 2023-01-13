RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  context 'when right is not zero' do
    let(:obj) { { left: { number: '9' }, operator: '/', right: { number: '3' } } }
    let(:context) { nil }

    it { is_expected.to eq(3) }
  end

  context 'when right is zero' do
    let(:obj) { { left: { number: '9' }, operator: '/', right: { number: '0' } } }
    let(:context) { nil }

    it do
      is_expected.to be_error
        .and be_is_a(XlsFunction::ErrorValue)
        .and eq("#DIV/0!")
    end
  end
end
