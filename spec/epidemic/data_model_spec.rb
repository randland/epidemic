require "spec_helper"

class TestCoercedObject < Epidemic::DataModel
  property :tag
  property :name
end

describe Epidemic::DataModel do
  describe ".is_truthy?" do
    it "detects booleans" do
      expect(described_class.is_truthy? false).to be false

      expect(described_class.is_truthy? true).to be true
    end

    it "detects integers" do
      expect(described_class.is_truthy? -1).to be false
      expect(described_class.is_truthy? 0).to be false
      expect(described_class.is_truthy? 0.1).to be false

      expect(described_class.is_truthy? 1).to be true
      expect(described_class.is_truthy? 1.1).to be true
      expect(described_class.is_truthy? 2).to be true
    end

    it "detects strings" do
      expect(described_class.is_truthy? 'false').to be false
      expect(described_class.is_truthy? 'False').to be false
      expect(described_class.is_truthy? 'FALSE').to be false
      expect(described_class.is_truthy? 'f').to be false
      expect(described_class.is_truthy? 'F').to be false
      expect(described_class.is_truthy? 'no').to be false
      expect(described_class.is_truthy? 'No').to be false
      expect(described_class.is_truthy? 'NO').to be false
      expect(described_class.is_truthy? 'n').to be false
      expect(described_class.is_truthy? 'N').to be false
      expect(described_class.is_truthy? '0').to be false
      expect(described_class.is_truthy? 'xyz').to be false

      expect(described_class.is_truthy? 'true').to be true
      expect(described_class.is_truthy? 'True').to be true
      expect(described_class.is_truthy? 'TRUE').to be true
      expect(described_class.is_truthy? 't').to be true
      expect(described_class.is_truthy? 'T').to be true
      expect(described_class.is_truthy? 'yes').to be true
      expect(described_class.is_truthy? 'Yes').to be true
      expect(described_class.is_truthy? 'YES').to be true
      expect(described_class.is_truthy? 'y').to be true
      expect(described_class.is_truthy? 'Y').to be true
      expect(described_class.is_truthy? '1').to be true
    end

    it "detects nil" do
      expect(described_class.is_truthy? nil).to be false
    end
  end

  describe ".coerce_objects" do
    subject { described_class.coerce_objects objects_to_coerce, to: TestCoercedObject, via: :tag }

    context "passed a nil object" do
      let(:objects_to_coerce) { nil }

      it "returns an empty hash" do
        expect(subject).to be_a_kind_of Hash
        expect(subject).to be_empty
      end
    end

    context "passed an empty array" do
      let(:objects_to_coerce) { [] }

      it "returns an empty hash" do
        expect(subject).to be_a_kind_of Hash
        expect(subject).to be_empty
      end
    end

    context "passed an empty hash" do
      let(:objects_to_coerce) { {} }

      it "returns an empty hash" do
        expect(subject).to be_a_kind_of Hash
        expect(subject).to be_empty
      end
    end

    context "passed an array of tag values as strings" do
      let(:objects_to_coerce) do
        %w(tag_1 tag_2)
      end

      it "returns a hash keyed by the values, and with the tags set" do
        expect(subject).to be_a_kind_of Hash
        objects_to_coerce.each do |tag|
          this_subject = subject[tag]
          expect(this_subject).to be_a_kind_of Hash
          expect(this_subject[:tag]).to eq tag
          expect(this_subject[:name]).to be_nil
        end
      end
    end

    context "passed an array of tag values as symbols" do
      let(:objects_to_coerce) do
        [:tag_1, :tag_2]
      end

      it "returns a hash keyed by the values, and with the tags set" do
        expect(subject).to be_a_kind_of Hash
        objects_to_coerce.each do |tag|
          this_subject = subject[tag]
          expect(this_subject).to be_a_kind_of Hash
          expect(this_subject[:tag]).to eq tag
          expect(this_subject[:name]).to be_nil
        end
      end
    end

    context "passed an array of hashes" do
      let(:objects_to_coerce) do
        [ {tag: :tag_1},
          {tag: :tag_2} ]
      end

      it "returns a hash keyed by the values, and with the tags set" do
        expect(subject).to be_a_kind_of Hash
        objects_to_coerce.each do |obj|
          tag = obj[:tag]
          this_subject = subject[tag]
          expect(this_subject).to be_a_kind_of Hash
          expect(this_subject[:tag]).to eq tag
          expect(this_subject[:name]).to be_nil
        end
      end
    end

    context "passed a hash" do
      let(:objects_to_coerce) do
        { tag_1: {},
          tag_2: {} }
      end

      it "returns a hash keyed by the values, and with the tags set" do
        expect(subject).to be_a_kind_of Hash
        objects_to_coerce.each do |tag, attrs|
          this_subject = subject[tag]
          expect(this_subject).to be_a_kind_of Hash
          expect(this_subject[:tag]).to eq tag
          expect(this_subject[:name]).to be_nil
        end
      end
    end
  end
end
