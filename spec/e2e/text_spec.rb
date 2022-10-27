RSpec.describe 'TEXT' do
  subject { XlsFunction.evaluate(input) }

  describe 'for String' do
    context 'pattern1' do
      let(:input) { 'TEXT("あいうえお", "これがTEXT関数@")' }

      it { is_expected.to eq('これがTEXT関数あいうえお') }
    end
  end

  describe 'for number' do
    context '#,#' do
      let(:input) { 'TEXT(1234567, "#,#")' }

      it { is_expected.to eq('1,234,567') }
    end

    context '?#;▲#' do
      let(:input) { "TEXT(#{number}, \"?#;▲#\")" }

      context '正の値' do
        let(:number) { 1 }

        it { is_expected.to eq(' 1') }
      end

      context '0' do
        let(:number) { 0 }

        it { is_expected.to eq(' ') }
      end

      context '-1' do
        let(:number) { -1 }

        it { is_expected.to eq('▲-1') }
      end
    end

    context '#,0,' do
      let(:input) { 'TEXT(1234567, "#,0,")' }

      it { is_expected.to eq('1,235') }
    end

    context '0,,' do
      let(:input) { 'TEXT(99999999999, "0,,")' }

      it { is_expected.to eq('100000') }
    end

    context '#%' do
      let(:input) { 'TEXT(0.1, "#%")' }

      it { is_expected.to eq('10%') }
    end
  end

  describe 'for date' do
    context 'yyyy/mm/dd hh:mm:ss AM/PM' do
      let(:input) { 'TEXT("2021/12/31 23:59:59", "yyyy/mm/dd hh:mm:ss AM/PM")' }

      it { is_expected.to eq('2021/12/31 11:59:59 PM') }
    end
  end
end
