RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'error' do
    let(:input) { 'FIND("no", "aiueo") + 1' }

    it { expect(subject.to_s).to eq("#{XlsFunction::ERROR_VALUE}FIND:#{I18n.t('xls_function.errors.missing_target', source: 'aiueo', target: 'no')}") }
  end
end
