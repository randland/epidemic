require 'spec_helper'

describe Epidemic::Gamestate do
  let(:gamestate) { Epidemic::Gamestate.new options }
  let(:options) { {} }

  subject { gamestate }

  context "Attributes" do
    context "diseases" do
      subject { gamestate.diseases }

      context "passed nothing" do
        it "creates black, blue, red, and yellow diseases" do
          expect(subject.count).to eq 4
          expect(subject.black).to be_a_kind_of Epidemic::Disease
          expect(subject.blue).to be_a_kind_of Epidemic::Disease
          expect(subject.red).to be_a_kind_of Epidemic::Disease
          expect(subject.yellow).to be_a_kind_of Epidemic::Disease
        end
      end

      context "passed an override hash" do
        context "containing a hash of diseases" do
          let(:options) { {diseases: {green: {}}} }
          it "creates the overridden diseases" do
            expect(subject.count).to eq 1
            expect(subject.green).to be_a_kind_of Epidemic::Disease
            expect(subject.green.color).to eq :green
          end
        end

        context "containing an array of hashes of diseases" do
          let(:options) { {diseases: [{color: :green}] } }
          it "creates the overridden diseases" do
            expect(subject.count).to eq 1
            expect(subject.green).to be_a_kind_of Epidemic::Disease
            expect(subject.green.color).to eq :green
          end
        end

        context "containing an array of disease colors" do
          let(:options) { {diseases: [:green] } }
          it "creates the overridden diseases" do
            expect(subject.count).to eq 1
            expect(subject.green).to be_a_kind_of Epidemic::Disease
            expect(subject.green.color).to eq :green
          end
        end

        context "containing a hash of diseases with overrides" do
          let(:options) { {diseases: {green: {available: '36', cured: '1'}}} }
          it "creates the overridden diseases" do
            expect(subject.count).to eq 1
            expect(subject.green).to be_a_kind_of Epidemic::Disease
            expect(subject.green.color).to eq :green
            expect(subject.green.available).to eq 36
            expect(subject.green.cured).to eq true
          end
        end
      end
    end
  end
end

