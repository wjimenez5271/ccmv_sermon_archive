namespace :db do
  desc "Populate database from uploaded sermon files"
  task :scansermons => :environment do
    Rake::Task['db:reset'].invoke
    Admin::SermonsHelper.rescan_files
  end
end
