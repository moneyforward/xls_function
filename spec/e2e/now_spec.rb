using ::XlsFunction::Extensions::TimeExtension

RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'NOW' do
    let(:input) { 'NOW()' }
    let(:now) { Time.now }

    before do
      allow_any_instance_of(XlsFunction::Evaluators::Functions::Now).to receive(:now).and_return(now)
    end

    it { is_expected.to eq(now.to_serial) }
  end
end
