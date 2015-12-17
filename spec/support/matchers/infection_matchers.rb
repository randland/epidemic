require 'rspec/expectations'

RSpec::Matchers.define :have_infections do |infections|
  match do |gamestate|
    @actual = gamestate
    @errors = []
    expected_available = gamestate.diseases.inject({}) do |memo, (color, disease)|
      memo.merge disease.color => 24
    end

    infections.each do |city_tag, infection_list|
      infection_list.each do |color, amt|
        expected_available[color] -= amt || 0
        unless (actual = gamestate.cities[city_tag].infections[color]) == amt
          @errors << "City #{city_tag} expects #{amt} #{color} infections, found #{actual}"
        end
      end
    end

    expected_available.each do |color, amt|
      unless (actual = gamestate.diseases[color].available) == amt
        @errors << "Disease #{color} expects #{amt} available, found #{actual}"
      end
    end

    @errors.empty?
  end

  failure_message do |actual|
    "expected #{actual} to have infections #{expected}\nErrors:\n  #{@errors.join "\n  "}"
  end
end

RSpec::Matchers.define :have_infection_deck do |*cards|
  match do |gamestate|
    @actual = gamestate.infection_deck.map &:city
    @actual == cards
  end

  failure_message do |actual|
    "expected #{actual} to match #{expected}"
  end
end

RSpec::Matchers.define :have_infection_discard do |*cards|
  match do |gamestate|
    @actual = gamestate.infection_discard.map &:city
    @actual == cards.flatten
  end

  failure_message do |actual|
    "expected #{actual} to match #{expected}"
  end
end

