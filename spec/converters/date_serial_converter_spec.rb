RSpec.describe XlsFunction::Converters::DateSerialConverter do
  subject { described_class.date_to_serial(source).then { |serial| described_class.serial_to_date(serial) } }

  context '1900/1/1' do
    let(:source) { Date.new(1900, 1, 1) }

    it { is_expected.to have_attributes(year: 1900, month: 1, day: 1) }
  end

  context '2021/12/31' do
    let(:source) { Date.new(2021, 12, 31) }

    it { is_expected.to have_attributes(year: 2021, month: 12, day: 31) }
  end
end
