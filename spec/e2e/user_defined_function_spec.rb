module XlsFunction
  class Transform
    add_function :tocelsius, 'LAMBDA(temp, (5/9) * (temp-32))', description: 'avoid to fail the spec'
    add_function :proctest, ->(x) { x + 99 }, description: 'proctest'
  end
end

RSpec.describe XlsFunction do
  # https://support.microsoft.com/ja-jp/office/lambda-%E9%96%A2%E6%95%B0-bd212d27-1cd1-4321-a34a-ccbf254b8b67
  describe 'lambda' do
    context 'tocelsius' do
      subject { described_class.evaluate(input).round }

      let(:input) { 'TOCELSIUS(104)' }

      it { is_expected.to eq(40) }
    end
  end

  describe 'from_proc' do
    subject { described_class.evaluate(input) }

    let(:input) { 'PROCTEST(1)' }

    it { is_expected.to eq(100) }
  end
end
