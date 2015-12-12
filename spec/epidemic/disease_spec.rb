require 'spec_helper'

describe Epidemic::Disease do
  default_options = { color: :blue }

  with_options default_options: default_options do |obj|
    obj.it_behaves_like 'it has symbol property', :color, required: true
    obj.it_behaves_like 'it has integer property', :available, required: true, default: 24
    obj.it_behaves_like 'it has boolean property', :cured, default: false
    obj.it_behaves_like 'it has boolean property', :eradicated, default: false
  end
end

