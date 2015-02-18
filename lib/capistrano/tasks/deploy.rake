namespace :deploy do

  desc "Deploy your application"
  task :default do
    updating
  end

  Rake::Task["starting"].clear
  desc "Setup your git-based deployment app"
  task :starting do
    on roles :app do
      execute %{if test ! -d #{fetch(:deploy_to)}; then mkdir -p #{fetch(:deploy_to)} && chmod g+w #{fetch(:deploy_to)} 1>&2; true; fi}
      execute %{if test ! -d #{File.join(fetch(:deploy_to), ".git")}; then git clone #{repo_url} #{fetch(:deploy_to)} 1>&2; true; fi}
    end
  end

  Rake::Task["updating"].clear
  desc "Update the deployed code."
  task :updating do
    on roles :app do
      within fetch(:deploy_to) do
				execute "git", "fetch origin"

				if fetch(:revision)
      execute "git", "reset --hard #{fetch(:revision)}"
				else
      execute "git", "reset --hard #{fetch(:branch)}"
				end
      end
    end
  end

  Rake::Task["updated"].clear
  before :updated, "bundler:install" do
    on roles :app do
      within fetch(:deploy_to) do
				execute "sudo", "bundle"
      end
    end
  end

  Rake::Task["publishing"].clear

  Rake::Task["finishing"].clear
  desc "Finishing deployment"
  task :finishing do
    on roles :app do
      execute %{if test ! -d #{fetch(:deploy_to)}/tmp/sockets; then mkdir -p #{fetch(:deploy_to)}/tmp/sockets && chmod g+w #{fetch(:deploy_to)}/tmp/sockets 1>&2; true; fi}
    end
  end

  Rake::Task["finished"].clear

  after :finished, "puma:restart"

end
