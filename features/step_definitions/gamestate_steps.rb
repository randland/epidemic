Given(/^I have a new default gamestate$/) do
  @gamestate = Epidemic::Factories::GamestateFactory.create_game
end
