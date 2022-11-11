RSpec.describe XlsFunction::Parser do
  subject { described_class.new }

  describe 'simple number' do
    it { is_expected.to parse('1').as(number: '1') }
  end

  describe 'with decimal number' do
    it { is_expected.to parse('1.1').as(number: '1.1') }
  end

  describe 'boolean' do
    it { is_expected.to parse('true').as(true_expr: 'true') }
    it { is_expected.to parse('FALSE').as(false_expr: 'FALSE') }
  end

  describe 'simple string' do
    it { is_expected.to parse('"a"').as(string: 'a') }
  end

  describe 'empty string' do
    it { is_expected.to parse('""').as(string: []) }
  end

  describe 'variant' do
    it { is_expected.to parse('_hoge').as(variant: '_hoge') }
  end

  describe 'function call' do
    it { is_expected.to parse('LEFT("abc", 2)').as(identifier: 'LEFT', arglist: [{ string: 'abc' }, { number: '2' }]) }
  end

  describe 'binary operation' do
    it { is_expected.to parse('1 + 1').as(left: { number: '1' }, operator: '+', right: { number: '1' }) }

    it 'prefer Multiplication to Addition' do
      is_expected.to parse('1 + 2 * 3').as(
        left: { number: '1' },
        operator: '+',
        right: {
          left: { number: '2' },
          operator: '*',
          right: { number: '3' }
        }
      )
    end

    it 'Parentheses is the highest priority' do
      is_expected.to parse('(1 + 2) * 3').as(
        left: {
          left: { number: '1' },
          operator: '+',
          right: { number: '2' }
        },
        operator: '*',
        right: { number: '3' }
      )
    end

    it 'prefer Arithmetic operation to Comparison' do
      is_expected.to parse('1 + 1 = 2').as(
        left: {
          left: { number: '1' },
          operator: '+',
          right: { number: '1' }
        },
        operator: '=',
        right: { number: '2' }
      )
    end
  end

  describe 'function call with variant' do
    it { is_expected.to parse('LET(number, 1, number + 2)').as(identifier: 'LET', arglist: [{ variant: 'number' }, { number: '1' }, { left: { variant: 'number' }, operator: '+', right: { number: '2' } }]) }
  end
end
