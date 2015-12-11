require 'spec_helper'

describe Epidemic::Factories::GamestateFactory do
  let(:factory) { Epidemic::Factories::GamestateFactory }
  let(:options) { {} }

  context '.create_game' do
    subject { factory.create_game options }

    context 'passed no parameters' do
      it 'returns a Gamestate object' do
        expect(subject).to be_a_kind_of(Epidemic::Gamestate)
      end
    end
  end
end
