Given(/^I have a new default gamestate$/) do
  @gamestate = Epidemic::Factories::GamestateFactory.create_game
end

Then(/^the current gamestate should have the following ([^\W]*?):$/) do |attribute_name, table|
  actual = @gamestate.send attribute_name
  expected = parse_table table

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

Then(/^the current gamestate should have the following cities connected:$/) do |table|
  connections = table.raw
  connections.each do |city1, city2|
    expect(@gamestate.cities_connected_to city1).to include city2.to_sym
    expect(@gamestate.cities_connected_to city2).to include city1.to_sym
  end
end
