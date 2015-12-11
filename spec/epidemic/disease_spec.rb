require 'spec_helper'

describe Epidemic::Disease do
  context '#color' do
    subject { Epidemic::Disease.new options }

    context 'when not passed a color attribute' do
      let(:options) { {} }
      it 'does not allow a nil color attribute' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when passed a color attribute as a symbol' do
      let(:options) { {color: :blue} }
      it 'accepts the color attribute' do
        expect(subject.color).to eq :blue
      end
    end

    context 'when passed a color attribute as a string' do
      let(:options) { {color: 'blue'} }
      it 'accepts the color attribute, and coerces it to a symbol' do
        expect(subject.color).to eq :blue
      end
    end
  end
end
