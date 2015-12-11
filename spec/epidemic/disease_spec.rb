require 'spec_helper'

describe Epidemic::Disease do
  let(:test_obj) { Epidemic::Disease.new options }
  let(:default_options) { { color: :blue } }

  context '#color' do
    subject { test_obj.color }

    context 'when not passed a color attribute' do
      let(:options) { {} }

      it 'does not allow a nil color attribute' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when passed a color attribute as a symbol' do
      let(:options) { {color: :blue} }

      it 'accepts the color attribute' do
        expect(subject).to eq :blue
      end
    end

    context 'when passed a color attribute as a string' do
      let(:options) { {color: 'blue'} }

      it 'accepts the color attribute, and coerces it to a symbol' do
        expect(subject).to eq :blue
      end
    end
  end

  context '#available' do
    subject { test_obj.available }

    context 'when not passed an available attribute' do
      let(:options) { default_options }

      it 'defaults to 24 available' do
        expect(subject).to eq 24
      end
    end

    context 'when explicitly passing nil available' do
      let(:options) { default_options.merge available: nil }

      it 'does not allow nil' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when passed an available attribute as an integer' do
      let(:options) { default_options.merge available: 36 }

      it 'accepts the available attribute' do
        expect(subject).to eq 36
      end
    end

    context 'when passed an available attribute as a string' do
      let(:options) { default_options.merge available: '36' }

      it 'accepts the available attribute, and coerces it to an integer' do
        expect(subject).to eq 36
      end
    end
  end

  context '#cured' do
    subject { test_obj.cured }

    context 'when not passed a cured attribute' do
      let(:options) { default_options }

      it 'defaults to false' do
        expect(subject).to be false
      end
    end

    context 'when passed a boolean' do
      let(:options) { default_options.merge cured: true }

      it 'accepts the cured attribute' do
        expect(subject).to be true
      end
    end

    context 'when passed a truthy integer' do
      let(:options) { default_options.merge cured: 1 }

      it 'accepts the cured attribute, and coerces it to a boolean' do
        expect(subject).to be true
      end
    end

    context 'when passed a falsey integer' do
      let(:options) { default_options.merge cured: 0 }

      it 'accepts the cured attribute, and coerces it to a boolean' do
        expect(subject).to be false
      end
    end

    context 'when passed a truthy string' do
      let(:options) { default_options.merge cured: 'y' }

      it 'accepts the cured attribute, and coerces it to a boolean' do
        expect(subject).to be true
      end
    end

    context 'when passed a falsey string' do
      let(:options) { default_options.merge cured: 'n' }

      it 'accepts the cured attribute, and coerces it to a boolean' do
        expect(subject).to be false
      end
    end
  end

  context '#eradicated' do
    subject { test_obj.eradicated }

    context 'when not passed a eradicated attribute' do
      let(:options) { default_options }

      it 'defaults to false' do
        expect(subject).to be false
      end
    end

    context 'when passed a boolean' do
      let(:options) { default_options.merge eradicated: true }

      it 'accepts the eradicated attribute' do
        expect(subject).to be true
      end
    end

    context 'when passed a truthy integer' do
      let(:options) { default_options.merge eradicated: 1 }

      it 'accepts the eradicated attribute, and coerces it to a boolean' do
        expect(subject).to be true
      end
    end

    context 'when passed a falsey integer' do
      let(:options) { default_options.merge eradicated: 0 }

      it 'accepts the eradicated attribute, and coerces it to a boolean' do
        expect(subject).to be false
      end
    end

    context 'when passed a truthy string' do
      let(:options) { default_options.merge eradicated: 'y' }

      it 'accepts the eradicated attribute, and coerces it to a boolean' do
        expect(subject).to be true
      end
    end

    context 'when passed a falsey string' do
      let(:options) { default_options.merge eradicated: 'n' }

      it 'accepts the eradicated attribute, and coerces it to a boolean' do
        expect(subject).to be false
      end
    end
  end
end

