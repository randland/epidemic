require 'spec_helper'

describe Epidemic::City do
  default_options = { tag: :new_jersey, color: :blue }

  with_options default_options: default_options do |obj|
    obj.it_behaves_like 'it has symbol property', :tag, required: true
    obj.it_behaves_like 'it has symbol property', :color, required: true
    obj.it_behaves_like 'it has string property', :name, default: default_options[:tag].to_s.titleize
    obj.it_behaves_like 'it has collection of symbols property', :connections, default: []
  end
end

