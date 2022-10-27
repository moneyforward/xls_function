RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'DBCS' do
    let(:input) { "DBCS(\"#{string}\")" }

    context 'when NKF guesses string encoding as UTF-8' do
      let(:string) { '㈱ エクセルｴｸｾﾙＡＢＣABC' }

      it do
        expect(NKF.guess(string)).to be(Encoding::UTF_8)
        is_expected.to eq('㈱ エクセルエクセルＡＢＣＡＢＣ')
      end
    end

    context 'when NKF guesses string encoding as Shift_JIS' do
      let(:string) { '㈱ エクセル' }

      it do
        expect(NKF.guess(string)).to be(Encoding::Shift_JIS)
        is_expected.to eq('㈱ エクセル')
      end
    end
  end
end
