require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/puma"
require "capistrano/puma/workers"
require "capistrano/puma/nginx"

# Load custom tasks from `lib/capistrano/tasks" if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }


module Capistrano
	module DSL
		module Paths
			[:current, :release, :shared].each do |path|
				alias_method "#{path}_path", :deploy_path
			end
		end
	end
end
