require 'spec_helper'

describe Hash do
  describe "#deep_includes?" do
    it "looks for shallow matches" do
      search = {a: 1, b: 2}
      target = {a: 1, b: 2, c: 3}

      expect(target.deep_includes? search).to be true
    end

    it "rejects missing keys" do
      search = {a: 1, b: 2}
      target = {a: 1, c: 2}

      expect(target.deep_includes? search).to be false
    end

    it "rejects incorrect values" do
      search = {a: 1, b: 2}
      target = {a: 1, b: 3}

      expect(target.deep_includes? search).to be false
    end

    it "looks for deep matches" do
      search = {a: 1, b: {c: 2, d: 3}}
      target = {a: 1, b: {c: 2, d: 3, e: 4}, f: 5}

      expect(target.deep_includes? search).to be true
    end

    it "handles Hashie::Mash objects" do
      search = {a: 1, b: {c: 2, d: 3}}
      target = Hashie::Mash.new({a: 1, b: Hashie::Mash.new({c: 2, d: 3, e: 4}), f: 5})

      expect(target.deep_includes? search).to be true
    end

    it "is agnostic to key type with Hashie::Mash objects" do
      search = Hashie::Mash.new({a: 1, "b" => 2})
      target = Hashie::Mash.new({"a" => 1, b: 2, c: 3})

      expect(target.deep_includes? search).to be true
    end

    it "is agnostic to value type" do
      search = {a: 1, b: 2, c: 3}
      target = {a: 1, b: :'2', c: '3'}

      expect(target.deep_includes? search).to be true
    end

    it "handles arrays" do
      search = {a: [1, 2, 3]}
      target = {a: [1, 2, 3], b: 2}

      expect(target.deep_includes? search).to be true
    end

    it "handles strings vs symbols in arrays" do
      search = {a: ['symbol',:string]}
      target = {a: [:symbol,'string'], b: 2}

      expect(target.deep_includes? search).to be true
    end

    it "handles hashes in arrays" do
      search = {a: [{b: :b}, {c: :c}]}
      target = {a: [{b: :b, d: :d}, {c: :c, d: :d}], d: :d}

      expect(target.deep_includes? search).to be true
    end
  end
end

