RSpec.describe XlsFunction::FormatString::Transform do
  subject { transform.call(input) }

  let(:transform) { described_class.new.apply(obj, context) }
  let(:context) { nil }

  describe 'hour' do
    context 'full' do
      let(:obj) { stub_slice(hour: 'hh') }

      let(:input) { '2021/12/1 09:59:59' }

      it { is_expected.to eq('09') }
    end

    context 'half' do
      let(:obj) { stub_slice(hour: 'h') }

      let(:input) { '2021/12/1 09:59:59' }

      it { is_expected.to eq('9') }
    end
  end

  describe 'elapsed_hour' do
    context 'full' do
      let(:obj) { stub_slice(hour_elapsed: '[hh]') }

      let(:input) { '1899/12/31 01:00:00' }

      it { is_expected.to eq('01') }
    end

    context 'half' do
      let(:obj) { stub_slice(hour_elapsed: '[h]') }

      let(:input) { '1900/1/1 01:00:00' }

      it { is_expected.to eq('25') }
    end
  end

  describe 'minutes' do
    context 'full' do
      let(:obj) { stub_slice(minute: 'mm') }

      let(:input) { '2021/12/1 09:09:59' }

      it { is_expected.to eq('09') }
    end

    context 'half' do
      let(:obj) { stub_slice(minute: 'm') }

      let(:input) { '2021/12/1 09:09:59' }

      it { is_expected.to eq('9') }
    end
  end

  describe 'elapsed_minute' do
    context 'full' do
      let(:obj) { stub_slice(minute_elapsed: '[mm]') }

      let(:input) { '1899/12/31 00:01:00' }

      it { is_expected.to eq('01') }
    end

    context 'half' do
      let(:obj) { stub_slice(minute_elapsed: '[m]') }

      let(:input) { '1900/1/1 00:10:00' }

      it { is_expected.to eq('1450') }
    end
  end

  describe 'second' do
    context 'full' do
      let(:obj) { stub_slice(second: 'ss') }

      let(:input) { '2021/12/1 09:59:09' }

      it { is_expected.to eq('09') }
    end

    context 'half' do
      let(:obj) { stub_slice(second: 's') }

      let(:input) { '2021/12/1 09:59:09' }

      it { is_expected.to eq('9') }
    end

    context 'with millisecond' do
      let(:obj) { stub_slice(second: 'ss') & stub_slice(millisecond: '.000') }

      let(:input) { '2021/12/1 09:59:09.011' }

      it { is_expected.to eq('09.011') }
    end
  end

  describe 'elapsed_second' do
    context 'full' do
      let(:obj) { stub_slice(second_elapsed: '[ss]') }

      let(:input) { '1899/12/31 00:00:01' }

      it { is_expected.to eq('01') }
    end

    context 'half' do
      let(:obj) { stub_slice(second_elapsed: '[s]') }

      let(:input) { '1900/1/1 00:00:01' }

      it { is_expected.to eq('86401') }
    end
  end

  describe 'times' do
    let(:obj) do
      {
        times: [
          expr(:time, stub_slice(hour: 'hh')),
          expr(:texts, [expr(:text, stub_slice(string: '時'))]) & expr(:time, stub_slice(minute: 'mm')),
          expr(:texts, [expr(:text, stub_slice(string: ' '))]),
          stub_slice(ampm: 'a/p')
        ]
      }
    end

    let(:input) { '2021/12/1 14:00:00' }

    it { is_expected.to eq('02時00 p') }
  end
end
