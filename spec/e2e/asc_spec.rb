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

    context 'when the string contains 2-byte spaces' do
      let!(:string) { '㈱　エクセル' } # Note the 2-byte space between characters

      it 'converts 2-byte spaces to 1-byte spaces' do
        is_expected.to eq('㈱ ｴｸｾﾙ') # Note the 1-byte space between characters
      end
    end

    context 'when the string is empty' do
      let!(:string) { '' }

      it 'returns an empty string' do
        is_expected.to eq('')
      end
    end

    context 'when the string contains only 2-byte spaces' do
      let!(:string) { '　　' } # Only 2-byte spaces

      it 'converts 2-byte spaces to 1-byte spaces' do
        is_expected.to eq('  ') # Only 1-byte spaces
      end
    end

    context 'when the string contains a mix of 1-byte and 2-byte spaces' do
      let!(:string) { '㈱　エクセル ｴｸｾﾙ' } # Mix of 1-byte and 2-byte spaces

      it 'converts only 2-byte spaces to 1-byte spaces' do
        is_expected.to eq('㈱ ｴｸｾﾙ ｴｸｾﾙ') # Only 1-byte spaces
      end
    end
  end
end
