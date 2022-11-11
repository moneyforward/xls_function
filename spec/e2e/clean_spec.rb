RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'CLEAN' do
    let(:input) { "CLEAN(\"#{9.chr}Excel#{10.chr}\")" }

    it { is_expected.to eq('Excel') }

    context 'when unicode charset' do
      let(:input) { "CLEAN(\"#{144.chr(Encoding::UTF_8)}\")" }

      it { is_expected.to eq('') }
    end

    context 'when nothings clean' do
      let(:input) { 'CLEAN("abc")' }

      it { is_expected.to eq('abc') }
    end
  end
end
