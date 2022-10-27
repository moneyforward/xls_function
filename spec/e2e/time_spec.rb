RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'TIME' do
    let(:input) { "TIME(#{hour}, #{minute}, #{second})" }

    let(:hour) { 0 }
    let(:minute) { 0 }
    let(:second) { 0 }

    it { is_expected.to eq(0) }

    context 'negative value' do
      let(:hour) { 2 }
      let(:minute) { -58 }
      let(:second) { 0 }

      it { is_expected.to eq(0.043055555555556) } # 1:02:00
    end

    context 'elapsed' do
      let(:hour) { 27 }
      let(:minute) { 0 }
      let(:second) { 0 }

      it { is_expected.to eq(0.125) } # 3:00:00
    end

    context 'total negative' do
      let(:hour) { 0 }
      let(:minute) { 0 }
      let(:second) { -1 }

      it { is_expected.to be_error }
    end
  end
end
