RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  let(:input) { "ASC(\"#{string}\")" }

  describe 'ASC' do
    context 'when NKF guesses string encoding as UTF-8' do
      let(:string) { '㈱ エクセルｴｸｾﾙＡＢＣABC' }

      it do
        expect(NKF.guess(string)).to be(Encoding::UTF_8)
        is_expected.to eq('㈱ ｴｸｾﾙｴｸｾﾙABCABC')
      end
    end

    context 'when NKF guesses string encoding as Shift_JIS' do
      let(:string) { '㈱ エクセル' }

      it do
        expect(NKF.guess(string)).to be(Encoding::Shift_JIS)
        is_expected.to eq('㈱ ｴｸｾﾙ')
      end
    end
  end
end
