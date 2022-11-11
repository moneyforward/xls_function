RSpec.describe XlsFunction::Converters::TimeSerialConverter do
  subject { described_class.time_to_serial(source).then { |serial| described_class.serial_to_time(serial) } }

  context '00:00:00.000' do
    let(:source) { Time.parse('2021/12/1 00:00:00.000') }

    it { is_expected.to have_attributes(hour: 0, min: 0, sec: 0, usec: 0) }
  end

  context '23:59:59.999' do
    let(:source) { Time.parse('2021/12/1 23:59:59.999') }

    it { is_expected.to have_attributes(hour: 23, min: 59, sec: 59, usec: 999_000) }
  end
end
