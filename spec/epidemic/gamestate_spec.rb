require 'spec_helper'

describe Epidemic::Gamestate do
  let(:test_obj) { Epidemic::Gamestate.new options }
  let(:default_options) { {} }

  describe '#max_outbreaks' do
    subject { test_obj.max_outbreaks }

    context 'when not passed any overrides' do
      let(:options) { default_options.except :max_outbreaks }

      it 'defaults to 7' do
        expect(subject).to eq 7
      end
    end

    context 'when passed an override as an integer' do
      let(:options) { default_options.merge max_outbreaks: 2 }

      it 'accepts the override' do
        expect(subject).to eq 2
      end
    end

    context 'when passed an override as a string' do
      let(:options) { default_options.merge max_outbreaks: '2' }

      it 'accepts the override and coerces it into an integer' do
        expect(subject).to eq 2
      end
    end
  end

  describe '#outbreaks' do
    subject { test_obj.outbreaks }

    context 'when not passed any overrides' do
      let(:options) { default_options.except :outbreaks }

      it 'defaults to 0' do
        expect(subject).to eq 0
      end
    end

    context 'when passed an override as an integer' do
      let(:options) { default_options.merge outbreaks: 2 }

      it 'accepts the override' do
        expect(subject).to eq 2
      end
    end

    context 'when passed an override as a string' do
      let(:options) { default_options.merge outbreaks: '2' }

      it 'accepts the override and coerces it into an integer' do
        expect(subject).to eq 2
      end
    end
  end

  describe "#cities" do
    subject { test_obj.cities }

    context "passed nothing" do
      let(:options) { default_options.except :cities }

      it "creates the default cities" do
        expect(subject.count).to eq 48
        %w(algiers atlanta baghdad bangkok bejing bogota buenos_aires cairo
        chennai chicago delhi essen ho_chi_minh_city hong_kong istanbul
        jakarta johannesburg karachi khartoum kinshasa kolkata lagos lima
        london los_angeles madrid manila mexico_city miami milan montreal
        moscow mumbai new_york osaka paris riyadh san_francisco santiago
        sao_paulo seoul shanghai st_petersburg sydney taipei tehran tokyo
        washington).each do |city_tag|
          expect(subject.send(city_tag)).to be_a_kind_of Epidemic::City
        end
      end
    end

    context "passed an override hash" do
      context "containing a hash of cities" do
        let(:options) do
          default_options.merge cities: {
            madison: {color: :blue}
          }
        end

        it "creates the overridden cities" do
          expect(subject.count).to eq 1
          expect(subject.madison).to be_a_kind_of Epidemic::City
          expect(subject.madison.tag).to eq :madison
          expect(subject.madison.color).to eq :blue
        end
      end

      context "containing an array of hashes of cities" do
        let(:options) do
          default_options.merge cities: [
            { tag: 'madison',
              color: 'blue' }
          ]
        end

        it "creates the overridden cities" do
          expect(subject.count).to eq 1
          expect(subject.madison).to be_a_kind_of Epidemic::City
          expect(subject.madison.tag).to eq :madison
          expect(subject.madison.color).to eq :blue
        end
      end
    end
  end

  describe "#diseases" do
    subject { test_obj.diseases }

    context "passed nothing" do
      let(:options) { default_options.except :diseases }

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
        let(:options) do
          default_options.merge diseases: {
            green: {}
          }
        end

        it "creates the overridden diseases" do
          expect(subject.count).to eq 1
          expect(subject.green).to be_a_kind_of Epidemic::Disease
          expect(subject.green.color).to eq :green
        end
      end

      context "containing an array of hashes of diseases" do
        let(:options) do
          default_options.merge diseases: [
              { color: :green }
          ]
        end

        it "creates the overridden diseases" do
          expect(subject.count).to eq 1
          expect(subject.green).to be_a_kind_of Epidemic::Disease
          expect(subject.green.color).to eq :green
        end
      end

      context "containing an array of disease colors" do
        let(:options) do
          default_options.merge diseases: [
            :green
          ]
        end

        it "creates the overridden diseases" do
          expect(subject.count).to eq 1
          expect(subject.green).to be_a_kind_of Epidemic::Disease
          expect(subject.green.color).to eq :green
        end
      end

      context "containing a hash of diseases with overrides" do
        let(:options) do
          default_options.merge diseases: {
            green: { available: '36',
                     cured: '1' }
          }
        end

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

