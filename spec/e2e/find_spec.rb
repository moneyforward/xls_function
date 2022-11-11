RSpec.describe XlsFunction do
  subject { described_class.evaluate(input) }

  describe 'FIND' do
    let(:input) { "FIND(#{target}, #{source})" }

    let(:source) { '"abcde abcde"' }
    let(:target) { '"cd"' }

    it { is_expected.to eq(3) }

    context 'when start passed' do
      let(:input) { "FIND(#{target}, #{source}, #{start})" }
      let(:start) { 4 }

      it { is_expected.to eq(9) }
    end

    context 'cannot find' do
      let(:target) { '"fg"' }

      it { is_expected.to be_error }
    end
  end
end
