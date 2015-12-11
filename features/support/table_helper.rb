module TableHelper
  def table_to_hash(table, key_field=nil)
    hash = {}
    tmp_tbl = table.dup
    columns = tmp_tbl.shift.map {|title| title.downcase.gsub(/\W+/, '_')}
    key_field ||= columns.first
    tmp_tbl.each do |row|
      this_hash = {}
      this_key = nil
      row.each_with_index do |val, idx|
        column = columns[idx]
        this_key = val if column == key_field
        this_hash[column] = val
      end
      hash[this_key] = this_hash
    end
    hash
  end
end

World(TableHelper)

