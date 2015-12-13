require 'spec_helper'

describe Epidemic::Gamestate do
  it_behaves_like 'it has integer property', :max_outbreaks, default: 7
  it_behaves_like 'it has integer property', :outbreaks, default: 0
  it_behaves_like 'it has integer property', :total_epidemics, default: 5
  it_behaves_like 'it has integer property', :played_epidemics, default: 0
  it_behaves_like 'it has hash property', :cities,
    of_type: Epidemic::City,
    keyed_on: :tag,
    default_config: 'cities',
    stubbed_attrs: {color: :black}
  it_behaves_like 'it has hash property', :diseases,
    of_type: Epidemic::Disease,
    keyed_on: :color,
    default_config: 'diseases'
end

