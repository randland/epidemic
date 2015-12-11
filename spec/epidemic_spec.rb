require 'spec_helper'

class TestCoercedObject < Hashie::Dash
  include Hashie::Extensions::Dash::Coercion
  property :tag
  property :name
end

describe Epidemic do
  it 'has a version number' do
    expect(Epidemic::VERSION).not_to be nil
  end

  context "object coercion" do
    subject { Epidemic.coerce_objects objects_to_coerce, to: TestCoercedObject, via: :tag }

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

