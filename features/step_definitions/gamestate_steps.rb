Given(/^I have a new default gamestate$/) do
  @gamestate = Epidemic::Factories::GamestateFactory.create_game
end

Then(/^the current gamestate should have the following (.*?):$/) do |attribute_name, table|
  actual = @gamestate.send attribute_name
  expected = table_to_hash table.raw

  if actual.respond_to? :count
    expect(actual.count).to eq expected.count
  else
    expect(actual).to be
  end

  expected.each do |key, expected_attrs|
    expected_attrs.each do |attr_key, expected_val|
      actual_val = actual[key].send(attr_key).to_s
      expect(actual_val).to eq expected_val
    end
  end
end

