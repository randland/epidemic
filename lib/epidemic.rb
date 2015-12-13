require "epidemic/version"

require "active_support/all"
require "hashie"
require 'yaml'
require 'pathname'

def require_dir(dir, from:File.expand_path('../', __FILE__))
  $LOAD_PATH.unshift from unless $LOAD_PATH.include? from
  base_path = Pathname.new from
  Dir[base_path.join dir, "**/*.rb"].each do |f|
    require Pathname.new(f).relative_path_from(base_path).to_s.sub(/\.rb$/, '')
  end
end

require_dir "epidemic/extensions"
require_dir "epidemic/factories"
require "epidemic/gamestate"

