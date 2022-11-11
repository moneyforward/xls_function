RSpec.describe XlsFunction::FormatString::Parser do
  subject { described_class.new }

  describe 'texts' do
    it { is_expected.to parse('G/標準').as(for_all: [{ texts: [expr(:text, placeholder: 'G/標準')] }]) }
    it { is_expected.to parse('@').as(for_all: [{ texts: [expr(:text, placeholder: '@')] }]) }
    it { is_expected.to parse(' 様').as(for_all: [{ texts: [expr(:text, string: ' '), expr(:text, string: '様')] }]) }
    it { is_expected.to parse('!@').as(for_all: [{ texts: [expr(:text, string: '@')] }]) }
    it { is_expected.to parse('(@)').as(for_all: [{ texts: [expr(:text, string: '('), expr(:text, placeholder: '@'), expr(:text, string: ')')] }]) }
  end

  describe 'numbers' do
    it { is_expected.to parse('?').as(for_all: [{ numbers: expr(:number, digit_q: '?') }]) }
    it { is_expected.to parse('###').as(for_all: [{ numbers: expected_digits('###') }]) }
    it { is_expected.to parse('#,##0').as(for_all: [{ numbers: [expr(:number, digit_s: '#'), expr(:texts, [expr(:text, string: ',')]) & expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_z: '0') ] }]) }
    it { is_expected.to parse('###0,').as(for_all: [{ numbers: [expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_z: '0'), { string: ',' }] }]) }
    it { is_expected.to parse('#,##0,').as(for_all: [{ numbers: [expr(:number, digit_s: '#'), expr(:texts, [expr(:text, string: ',')]) & expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_z: '0'), { string: ',' } ] }]) }
    it { is_expected.to parse('#,##0,,').as(for_all: [{ numbers: [expr(:number, digit_s: '#'), expr(:texts, [expr(:text, string: ',')]) & expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_z: '0'), { string: ',' }, { string: ',' } ] }]) }
    it { is_expected.to parse('0%').as(for_all: [{ numbers: expr(:number, digit_z: '0') & { string: '%' } }]) }
    it { is_expected.to parse('#.00').as(for_all: [{ numbers: [expr(:number, digit_s: '#'), { texts: [expr(:text, string: '.')], **expr(:number, digit_z: '0') }, expr(:number, digit_z: '0')] }]) }
    it { is_expected.to parse('?.').as(for_all: [{ numbers: expr(:number, digit_q: '?') & { string: '.' } }]) }
    it { is_expected.to parse('###-####').as(for_all: [{ numbers: [expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), { texts: [expr(:text, string: '-')], **expr(:number, digit_s: '#') }, expr(:number, digit_s: '#'), expr(:number, digit_s: '#'), expr(:number, digit_s: '#')] }]) }
  end

  describe 'dates' do
    it { is_expected.to parse('yy').as(for_all: [{ dates: expr(:date, year: 'yy') }]) }
    it { is_expected.to parse('yyyy/mm/dd').as(for_all: [{ dates: [expr(:date, year: 'yyyy'), { texts: [expr(:text, string: '/')], **expr(:date, month: 'mm') }, { texts: [ expr(:text, string: '/')], **expr(:date, day: 'dd') }] }]) }
    it { is_expected.to parse('(aaa)').as(for_all: [{ texts: [expr(:text, string: '(')] }, { dates: expr(:date, weekday: 'aaa') }, { texts: [expr(:text, string: ')')] }]) }

    context 'has gannen expression' do
      it { is_expected.to parse('[$-ja-JP-x-gannen]ggge').as(for_all: [{ dates: [{ date: { gannen: '[$-ja-JP-x-gannen]' } }, { date: { gengo: 'ggg' } }, { date: { wareki: 'e' } }] }]) }
    end
  end

  describe 'times' do
    it { is_expected.to parse('hh').as(for_all: [{ times: { time: { hour: 'hh' } } }]) }
    it { is_expected.to parse('hhmm').as(for_all: [{ times: [{ time: { hour: 'hh' } }, { time: { minute: 'mm' } }] }]) }
    it { is_expected.to parse('hh:mm').as(for_all: [{ times: [{ time: { hour: 'hh' } }, { texts: [expr(:text, string: ':')], time: { minute: 'mm' } }] }]) }
    it { is_expected.to parse('hh:mm:ss').as(for_all: [{ times: [{ time: { hour: 'hh' } }, { texts: [expr(:text, string: ':')], time: { minute: 'mm' } }, { texts: [expr(:text, string: ':')], time: { second: 'ss' } }] }]) }
    it { is_expected.to parse('h:mm:ss.00').as(for_all: [{ times: [{ time: { hour: 'h' } }, { texts: [expr(:text, string: ':')] , time: { minute: 'mm' } }, { texts: [expr(:text, string: ':')], time: { second: 'ss', millisecond: '.00' } }] }]) }
    it { is_expected.to parse('h:mm AM/PM').as(for_all: [{ times: [{ time: { hour: 'h' } }, { texts: [expr(:text, string: ':')], time: { minute: 'mm' } }, { texts: [expr(:text, string: ' ')] }, { ampm: 'AM/PM' }] }]) }
    it { is_expected.to parse('mm:ss').as(for_all: [{ times: [expr(:time, minute: 'mm'), expr(:texts, [expr(:text, string: ':')]) & expr(:time, second: 'ss')] }]) }
  end

  describe 'complex pattern' do
    context 'dates and times' do
      let(:expected) do
        {
          for_all: [
            {
              dates:
                [
                  expr(:date, year: 'yyyy'),
                  { texts: [expr(:text, string: '/')], **expr(:date, month: 'mm') },
                  { texts: [expr(:text, string: '/')], **expr(:date, day: 'dd') }
                ]
            },
            { texts: [expr(:text, string: ' ')] },
            {
              times:
                [
                  expr(:time, hour: 'hh'),
                  { texts: [expr(:text, string: ':')], **expr(:time, minute: 'mm') },
                  { texts: [expr(:text, string: ':')], **expr(:time, second: 'ss') },
                  { texts: [expr(:text, string: ' ')] },
                  { ampm: 'AM/PM' }
                ]
            }
          ]
        }
      end

      it { is_expected.to parse('yyyy/mm/dd hh:mm:ss AM/PM').as(expected) }
    end

    context 'with single semicolon' do
      let(:expected) do
        {
          for_plus_and_zero: [{
            numbers:
              [
                expr(:number, digit_s: '#'),
                { texts: [expr(:text, string: ',')], **expr(:number, digit_s: '#')},
                expr(:number, digit_s: '#'),
                expr(:number, digit_z: '0')
              ]
          }],
          for_minus: [
            { texts: [expr(:text, string: '▲')] },
            { numbers: expr(:number, digit_s: '#') }
          ]
        }
      end

      it { is_expected.to parse('#,##0; ▲#').as(expected) }
    end

    context 'with two semicolon' do
      let(:expected) do
        {
          for_plus: [{
            numbers:
              [
                expr(:number, digit_s: '#'),
                expr(:texts, [expr(:text, string: ',')]) & expr(:number, digit_z: '0')
              ]
          }],
          for_minus: [{
            numbers:
              [
                expr(:number, digit_s: '#'),
                expr(:texts, [expr(:text, string: ',')]) & expr(:number, digit_s: '#')
              ]
          }],
          for_zero: []
        }
      end

      it { is_expected.to parse('#,0 ; #,# ;').as(expected) }
    end

    context 'with three semicolon' do
      let(:expected) do
        {
          for_plus: [],
          for_minus: [],
          for_zero: [],
          for_string: []
        }
      end

      it { is_expected.to parse(';;;').as(expected) }
    end
  end
end
