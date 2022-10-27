RSpec.describe XlsFunction::FormatString::Transform do
  subject { transform.call(input) }

  let(:transform) { described_class.new.apply(obj, context) }

  describe 'digit_s' do
    let(:obj) { stub_slice(digit_s: '#') }
    let(:context) { nil }

    let(:input) { 1 }

    it { is_expected.to eq('1') }
    it 'respond_to digits?' do
      expect(transform).to be_respond_to(:digits?)
    end

    context 'when empty string' do
      let(:input) { '' }

      it { is_expected.to eq('') }
    end
  end

  describe 'digit_z' do
    let(:obj) { stub_slice(digit_z: '0') }
    let(:context) { nil }

    let(:input) { 1 }

    it { is_expected.to eq('1') }
    it 'respond_to digits?' do
      expect(transform).to be_respond_to(:digits?)
    end

    context 'when empty string' do
      let(:input) { '' }

      it { is_expected.to eq('0') }
    end
  end

  describe 'digit_q' do
    let(:obj) { stub_slice(digit_q: '?') }
    let(:context) { nil }

    let(:input) { 1 }

    it { is_expected.to eq('1') }
    it 'respond_to digits?' do
      expect(transform).to be_respond_to(:digits?)
    end

    context 'when empty string' do
      let(:input) { '' }

      it { is_expected.to eq(' ') }
    end
  end

  describe 'numbers' do
    context 'simple number' do
      let(:obj) { { numbers: expr(:number, stub_slice(digit_s: '#')) } }
      let(:context) { nil }

      let(:input) { 1 }

      it { is_expected.to eq('1') }

      context 'larger input' do
        let(:input) { 1000 }

        it { is_expected.to eq('1000') }
      end

      context 'minus input' do
        let(:input) { -10 }

        it { is_expected.to eq('-10') }
      end
    end

    context 'with comma' do
      let(:obj) do
        {
          numbers:
            [
              expr(:number, stub_slice(digit_s: '#')),
              expr(:texts, [stub_slice(string: ',')]) & expr(:number, stub_slice(digit_s: '#'))
            ]
        }
      end
      let(:context) { nil }

      context 'less than 1000' do
        let(:input) { 10 }

        it { is_expected.to eq('10') }
      end

      context '1000' do
        let(:input) { 1000 }

        it { is_expected.to eq('1,000') }
      end
    end

    context 'with comma and decimal' do
      let(:obj) do # => #,#.0
        {
          numbers:
            [
              expr(:number, stub_slice(digit_s: '#')),
              expr(:texts, [expr(:text, [stub_slice(string: ',')])]) & expr(:number, stub_slice(digit_s: '#')),
              expr(:texts, [expr(:text, [stub_slice(string: '.')])]) & expr(:number, stub_slice(digit_z: '0'))
            ]
        }
      end
      let(:context) { nil }

      context '100.0' do
        let(:input) { 100.0 }

        it { is_expected.to eq('100.0') }
      end

      context '100.05' do
        let(:input) { 100.05 }

        it { is_expected.to eq('100.1') }
      end

      context '1000.04' do
        let(:input) { 1000.04 }

        it { is_expected.to eq('1,000.0') }
      end
    end

    context 'with comma and decimal many format' do
      let(:obj) do # => #,#.###
        {
          numbers:
            [
              expr(:number, stub_slice(digit_s: '#')),
              expr(:texts, [expr(:text, [stub_slice(string: ',')])]) & expr(:number, stub_slice(digit_s: '#')),
              expr(:texts, [expr(:text, [stub_slice(string: '.')])]) & expr(:number, stub_slice(digit_z: '#')),
              expr(:number, stub_slice(digit_s: '#')),
              expr(:number, stub_slice(digit_s: '#'))
            ]
        }
      end
      let(:context) { nil }

      context '1.02' do
        let(:input) { 1.02 }

        it { is_expected.to eq('1.02') }
      end
    end
  end
end
