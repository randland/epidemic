require 'spec_helper'

describe Epidemic::City do
  let(:test_obj) { Epidemic::City.new options }
  let(:default_options) { { tag: :new_jersey, color: :blue } }

  describe '#tag' do
    subject { test_obj.tag }

    context 'when not passed a tag attribute' do
      let(:options) { default_options.except :tag }

      it 'does not allow a nil tag attribute' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when passed a tag attribute as a symbol' do
      let(:options) { default_options.merge tag: :new_jersey }

      it 'accepts the tag attribute' do
        expect(subject).to eq :new_jersey
      end
    end

    context 'when passed a tag attribute as a string' do
      let(:options) { default_options.merge tag: 'new_jersey' }

      it 'accepts the tag attribute, and coerces it to a symbol' do
        expect(subject).to eq :new_jersey
      end
    end
  end

  describe '#color' do
    subject { test_obj.color }

    context 'when not passed a color attribute' do
      let(:options) { default_options.except :color }

      it 'does not allow a nil color attribute' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when passed a color attribute as a symbol' do
      let(:options) { default_options.merge color: :blue }

      it 'accepts the color attribute' do
        expect(subject).to eq :blue
      end
    end

    context 'when passed a color attribute as a string' do
      let(:options) { default_options.merge color: 'blue' }

      it 'accepts the color attribute, and coerces it to a symbol' do
        expect(subject).to eq :blue
      end
    end
  end

  describe '#name' do
    subject { test_obj.name }

    context 'when not passed a name attribute' do
      let(:options) { default_options.except :name }

      it 'determines an appropriate name based on the tag' do
        expect(subject).to eq 'New Jersey'
      end
    end

    context 'when passed a name attribute as a symbol' do
      let(:options) { default_options.merge name: :'New Jersey'}

      it 'accepts the name attribute, and coerces it to a string' do
        expect(subject).to eq 'New Jersey'
      end
    end

    context 'when passed a name attribute as a string' do
      let(:options) { default_options.merge name: 'New Jersey' }

      it 'accepts the name attribute' do
        expect(subject).to eq 'New Jersey'
      end
    end
  end
end

