module TableHelper
  def parse_table(table, keyed_on:nil)
    Parser.new(table, keyed_on: keyed_on).parsed_result
  end

  class Parser
    attr_accessor :table, :columns, :key_field

    def initialize(table, keyed_on:nil)
      self.table = table.try(:raw) || table.dup
      self.columns = self.table.shift.map &:snakify
      self.key_field = keyed_on || columns.first
    end

    def parsed_result
      table.inject(Hashie::Mash.new) do |memo, row|
        memo.merge extract_row row
      end
    end

    private

    def extract_row(row)
      key = nil
      attrs = columns.zip(row).inject(Hashie::Mash.new) do |memo, (field, val)|
        key = val if field == key_field
        memo.merge field => val
      end
      {key => attrs}
    end
  end
end

World(TableHelper)

