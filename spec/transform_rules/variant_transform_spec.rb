RSpec.describe XlsFunction::Transform do
  subject { described_class.new.apply(obj, context).evaluate }

  let(:obj) { { variant: 'hoge' } }
  let(:context) { { variants: { 'hoge' => 'foo' } } }

  it { is_expected.to eq('foo') }

  context 'when missing variant definition' do
    let(:context) { nil }

    it { expect { subject }.to raise_error(XlsFunction::Transform::VariantUndefinedError) }
  end
end
