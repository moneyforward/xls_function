using ::XlsFunction::Extensions::DateExtension

RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'TODAY' do
    let(:input) { 'TODAY()' }
    let(:today) { Date.today }

    before do
      allow_any_instance_of(XlsFunction::Evaluators::Functions::Today).to receive(:today).and_return(today)
    end

    it { is_expected.to eq(today.to_serial) }
  end
end
