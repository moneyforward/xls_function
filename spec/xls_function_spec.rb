RSpec.describe XlsFunction do
  it 'has a version number' do
    expect(XlsFunction::VERSION).not_to be nil
  end

  describe '.evaluate' do
    subject { XlsFunction.evaluate(source) }

    let(:source) { 'LEFT("abcde", 1)' }
    it { is_expected.to eq('a') }
  end

  describe '#functions' do
    it 'is expected to define description' do
      function_without_description = XlsFunction.functions.values.select { |function| function[:description].nil? }
      expect(function_without_description.count).to eq 0
    end
  end
end
