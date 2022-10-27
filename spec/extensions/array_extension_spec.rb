RSpec.describe XlsFunction::Extensions::ArrayExtension do
  using described_class

  describe 'max_depth' do
    subject { array.max_depth }

    let(:array) { [1] }
    it { is_expected.to eq(1) }

    context 'two dimensions' do
      let(:array) { [1, [2]] }
      it { is_expected.to eq(2) }
    end

    context 'three dimensions' do
      let(:array) { [[[3]], [2], 1] }
      it { is_expected.to eq(3) }
    end

    context 'empty' do
      let(:array) { [] }
      it { is_expected.to eq(1) }
    end
  end
end
