RSpec.describe XlsFunction::FormatString::Transform do
  subject { described_class.new.apply(obj, context).call(input) }

  describe 'placeholder' do
    let(:obj) { stub_slice(placeholder: '@') }
    let(:context) { nil }

    let(:input) { 'inputs' }

    it { is_expected.to eq('inputs') }
  end

  describe 'string' do
    let(:obj) { stub_slice(string: 'a') }
    let(:context) { nil }

    let(:input) { 'inputs' }

    it { is_expected.to eq('a') }
  end

  describe 'text' do
    let(:obj) { { text: stub_slice(string: 'a') } }
    let(:context) { nil }

    let(:input) { 'inputs' }

    it { is_expected.to eq('a') }
  end

  describe 'texts' do
    let(:obj) { { texts: [expr(:text, **stub_slice(string: 'a')), expr(:text, **stub_slice(string: 'b'))] } }
    let(:context) { nil }

    let(:input) { 'inputs' }

    it { is_expected.to eq('ab') }
  end
end
