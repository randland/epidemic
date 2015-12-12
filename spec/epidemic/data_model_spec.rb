require "spec_helper"

class TestCoercedObject < Epidemic::DataModel
  property :tag
  property :name
end

def expect_truthy(val)
  expect(described_class.is_truthy? val).to be true
end

def expect_falsey(val)
  expect(described_class.is_truthy? val).to be false
end

describe Epidemic::DataModel do
  describe ".is_truthy?" do
    it "detects booleans" do
      expect_truthy true
      expect_falsey false
    end

    it "detects integers" do
      [-1, 0, 0.1].each {|val| expect_falsey val}
      [1, 1.1, 2].each {|val| expect_truthy val}
    end

    it "detects strings" do
      %w(false False FALSE f F no No NO n N 0 xyz).each {|val| expect_falsey val}
      %w(true True TRUE t T yes Yes YES y Y 1).each {|val| expect_truthy val}
    end

    it "detects nil" do
      expect_falsey nil
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
