require 'spec_helper'

describe Epidemic::City do
  let(:test_obj) { Epidemic::City.new options }
  let(:default_options) { { tag: :madison, color: :blue } }

  context '#tag' do
    subject { test_obj.tag }

    context 'when not passed a tag attribute' do
      let(:options) { default_options.reject {|k,v| k == :tag} }

      it 'does not allow a nil tag attribute' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when passed a tag attribute as a symbol' do
      let(:options) { default_options.merge tag: :madison }

      it 'accepts the tag attribute' do
        expect(subject).to eq :madison
      end
    end

    context 'when passed a tag attribute as a string' do
      let(:options) { default_options.merge tag: 'madison' }

      it 'accepts the tag attribute, and coerces it to a symbol' do
        expect(subject).to eq :madison
      end
    end
  end
end

