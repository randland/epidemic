require 'spec_helper'

describe Epidemic::Factories::GamestateFactory do
  let(:factory) { Epidemic::Factories::GamestateFactory }

  describe '.create_game' do
    subject { factory.create_game options }

    context 'passed no parameters' do
      let(:options) { {} }

      it 'returns a Gamestate object' do
        expect(subject).to be_a_kind_of(Epidemic::Gamestate)
        expect(subject.players).to_not be_empty
        expect(subject.player_deck).to_not be_empty
        expect(subject.player_discard).to be_empty
        expect(subject.infection_deck).to_not be_empty
        expect(subject.infection_discard.count).to eq 9
        expect(subject.diseases.values.map(&:available).inject(:+)).to eq 78
        expect(subject.cities.values.map(&:infections).map(&:values).flatten.inject(:+)).to eq 18
      end
    end
  end
end

