require 'spec_helper'

describe Epidemic::Services::InfectService do
  let(:gamestate) do
    Epidemic::Gamestate.new(
      cities: {
        city1: { color: :red,
                 connections: city1_connections },
        city2: { color: :red,
                 connections: city2_connections },
        city3: { color: :blue,
                 connections: city3_connections,
                 infections: { blue: 1 } }
      },
      diseases: {
        red: { available: 24 },
        blue: { available: 23 },
      },
      infection_deck: [
        { city: :city1, color: :red },
        { city: :city2, color: :red }
      ],
      infection_discard: [
        { city: :city3, color: :blue }
      ]
    )
  end
  let(:city1_connections) { [:city2, :city3] }
  let(:city2_connections) { [:city1, :city3] }
  let(:city3_connections) { [:city1, :city2] }

  context ".draw" do
    it "calls .draw! on a cloned gamestate" do
      gamestate = instance_double('Epidemic::Gamestate')
      cloned_gamestate = instance_double('Epidemic::Gamestate')
      result = double()

      expect(gamestate).to receive(:deep_clone).and_return(cloned_gamestate)
      expect(described_class).to receive(:draw!).with(cloned_gamestate, 2).and_return(result)

      expect(described_class.draw gamestate, 2).to eq result
    end
  end

  context ".draw!" do
    context "without count" do
      before :each do
        described_class.draw! gamestate
      end

      it 'infects the drawn city once' do
        expect(gamestate).to have_infections(
          city1: {red: 1},
          city2: {},
          city3: {blue: 1}
        )
      end

      it 'moves the drawn card to the discard' do
        expect(gamestate).to have_infection_deck :city2
        expect(gamestate).to have_infection_discard :city1, :city3
      end
    end

    context "with count" do
      before :each do
        described_class.draw! gamestate, 2
      end

      it 'infects the drawn city the indicated number of times' do
        expect(gamestate).to have_infections(
          city1: {red: 2},
          city2: {},
          city3: {blue: 1}
        )
      end

      it 'moves the drawn card to the discard' do
        expect(gamestate).to have_infection_deck :city2
        expect(gamestate).to have_infection_discard :city1, :city3
      end
    end

    context "with outbreak" do
      let(:city1_connections) { [:city2] }
      let(:city3_connections) { [:city2] }

      before :each do
        described_class.infect! gamestate, :city1, 3
        described_class.draw! gamestate
      end

      it 'infects adjacent cities' do
        expect(gamestate).to have_infections(
          city1: {red: 3},
          city2: {red: 1},
          city3: {blue: 1}
        )
      end

      it 'moves the drawn card to the discard' do
        expect(gamestate).to have_infection_deck :city2
        expect(gamestate).to have_infection_discard :city1, :city3
      end

      it 'increments the outbreak counter' do
        expect(gamestate.outbreaks).to eq 1
      end
    end

    context "with double outbreak" do
      before :each do
        described_class.infect! gamestate, :city1, 3
        described_class.infect! gamestate, :city2, 3
        described_class.draw! gamestate
      end

      it 'infects adjacent cities' do
        expect(gamestate).to have_infections(
          city1: {red: 3},
          city2: {red: 3},
          city3: {red: 2, blue: 1}
        )
      end

      it 'moves the drawn card to the discard' do
        expect(gamestate).to have_infection_deck :city2
        expect(gamestate).to have_infection_discard :city1, :city3
      end

      it 'increments the outbreak counter' do
        expect(gamestate.outbreaks).to eq 2
      end
    end
  end

  context ".infect" do
    it "calls .infect! on a cloned gamestate" do
      gamestate = instance_double('Epidemic::Gamestate')
      cloned_gamestate = instance_double('Epidemic::Gamestate')
      result = double()

      expect(gamestate).to receive(:deep_clone).and_return(cloned_gamestate)
      expect(described_class).to receive(:infect!).with(cloned_gamestate, :city_tag, 2).and_return(result)

      expect(described_class.infect gamestate, :city_tag, 2).to eq result
    end
  end

  context ".infect!" do
    context "without count" do
      before :each do
        described_class.infect! gamestate, :city1
      end

      it 'infects the drawn city once' do
        expect(gamestate).to have_infections(
          city1: {red: 1},
          city2: {},
          city3: {blue: 1}
        )
      end

      it 'does not change the infection deck' do
        expect(gamestate).to have_infection_deck :city1, :city2
        expect(gamestate).to have_infection_discard :city3
      end
    end

    context "with count" do
      before :each do
        described_class.infect! gamestate, :city1, 2
      end

      it 'infects the drawn city the indicated number of times' do
        expect(gamestate).to have_infections(
          city1: {red: 2},
          city2: {},
          city3: {blue: 1}
        )
      end

      it 'does not change the infection deck' do
        expect(gamestate).to have_infection_deck :city1, :city2
        expect(gamestate).to have_infection_discard :city3
      end
    end

    context "with outbreak" do
      let(:city1_connections) { [:city2] }
      let(:city3_connections) { [:city2] }

      before :each do
        described_class.infect! gamestate, :city1, 4
      end

      it 'infects adjacent cities' do
        expect(gamestate).to have_infections(
          city1: {red: 3},
          city2: {red: 1},
          city3: {blue: 1}
        )
      end

      it 'does not change the infection deck' do
        expect(gamestate).to have_infection_deck :city1, :city2
        expect(gamestate).to have_infection_discard :city3
      end

      it 'increments the outbreak counter' do
        expect(gamestate.outbreaks).to eq 1
      end
    end

    context "with double outbreak" do
      before :each do
        described_class.infect! gamestate, :city1, 3
        described_class.infect! gamestate, :city2, 4
      end

      it 'infects adjacent cities' do
        expect(gamestate).to have_infections(
          city1: {red: 3},
          city2: {red: 3},
          city3: {red: 2, blue: 1}
        )
      end

      it 'does not change the infection deck' do
        expect(gamestate).to have_infection_deck :city1, :city2
        expect(gamestate).to have_infection_discard :city3
      end

      it 'increments the outbreak counter' do
        expect(gamestate.outbreaks).to eq 2
      end
    end
  end
end

