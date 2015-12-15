require 'spec_helper'

describe Epidemic::Gamestate do
  let(:gamestate) { described_class.new options }
  let(:options) { {} }

  it_behaves_like 'it has integer property', :max_outbreaks, default: 7
  it_behaves_like 'it has integer property', :outbreaks, default: 0
  it_behaves_like 'it has integer property', :total_epidemics, default: 5
  it_behaves_like 'it has integer property', :played_epidemics, default: 0
  it_behaves_like 'it has collection of integers property', :infection_rates, default: [2, 2, 2, 3, 3, 4, 4]
  it_behaves_like 'it has hash property', :cities,
    of_type: Epidemic::City,
    keyed_on: :tag,
    default_config: 'cities',
    stubbed_attrs: {color: :black}
  it_behaves_like 'it has hash property', :diseases,
    of_type: Epidemic::Disease,
    keyed_on: :color,
    default_config: 'diseases'

  describe "#infection_rate" do
    subject { gamestate.infection_rate }
    let(:options) { { infection_rates: [1,2,3,4,5,6],
                      played_epidemics: played_epidemics } }

    context "without played epidemics" do
      let(:played_epidemics) { nil }

      it "returns the first infection rate" do
        expect(subject).to eq 1
      end
    end

    context "with 0 played epidemics" do
      let(:played_epidemics) { 0 }

      it "returns the first infection rate" do
        expect(subject).to eq 1
      end
    end

    context "with 3 played epidemics" do
      let(:played_epidemics) { 3 }

      it "returns the fourth infection rate" do
        expect(subject).to eq 4
      end
    end
  end
end

