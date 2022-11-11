RSpec.describe XlsFunction::FormatString::Transform do
  subject { transform.call(input) }

  let(:transform) { described_class.new.apply(obj, context) }
  let(:context) { nil }

  describe 'year' do
    context 'full' do
      let(:obj) { stub_slice(year: 'yyyy') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('2021') }
    end

    context 'half' do
      let(:obj) { stub_slice(year: 'yy') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('21') }
    end
  end

  describe 'month' do
    context 'm' do
      let(:obj) { stub_slice(month: 'm') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('9') }
    end

    context 'mm' do
      let(:obj) { stub_slice(month: 'mm') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('09') }
    end

    context 'mmm' do
      let(:obj) { stub_slice(month: 'mmm') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('Sep') }
    end

    context 'mmmm' do
      let(:obj) { stub_slice(month: 'mmmm') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('September') }
    end

    context 'mmmmm' do
      let(:obj) { stub_slice(month: 'mmmmm') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('S') }
    end
  end

  describe 'day' do
    context 'd' do
      let(:obj) { stub_slice(day: 'd') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('1') }
    end

    context 'dd' do
      let(:obj) { stub_slice(day: 'dd') }

      let(:input) { '2021/9/1' }

      it { is_expected.to eq('01') }
    end
  end

  describe 'weekday' do
    context 'aaa' do
      let(:obj) { stub_slice(weekday: 'aaa') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('水') }
    end

    context 'aaaa' do
      let(:obj) { stub_slice(weekday: 'aaaa') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('水曜日') }
    end

    context 'ddd' do
      let(:obj) { stub_slice(weekday: 'ddd') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('Wed') }
    end

    context 'dddd' do
      let(:obj) { stub_slice(weekday: 'dddd') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('Wednesday') }
    end
  end

  describe 'wareki' do
    context 'e' do
      let(:obj) { stub_slice(wareki: 'e') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('3') }
    end

    context 'ee' do
      let(:obj) { stub_slice(wareki: 'ee') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('03') }
    end

    context 'r' do
      let(:obj) { stub_slice(wareki: 'r') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('03') }
    end
  end

  describe 'gengo' do
    context 'g' do
      let(:obj) { stub_slice(gengo: 'g') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('R') }
    end

    context 'gg' do
      let(:obj) { stub_slice(gengo: 'gg') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('令') }
    end

    context 'ggg' do
      let(:obj) { stub_slice(gengo: 'ggg') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('令和') }
    end
  end

  describe 'gengo_wareki' do
    context 'gggee' do
      let(:obj) { stub_slice(gengo_wareki: 'gggee') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('令和03') }
    end

    context 'rr' do
      let(:obj) { stub_slice(gengo_wareki: 'rr') }

      let(:input) { '2021/12/1' }

      it { is_expected.to eq('令和03') }
    end
  end

  describe 'dates' do
    let(:obj) { { dates: [{ date: stub_slice(gannen: 'x') }, { date: stub_slice(gengo: 'ggg') }, { date: stub_slice(wareki: 'e') }] } }

    let(:input) { '2019/12/1' }

    it { is_expected.to eq('令和元') }
  end
end
