namespace :scan do
  desc "Scans for changes in the movie library folder."
  task :movies => :environment do
    p 'lol wow movie scan'
  end

  desc "Sends daily digest email to users with PM (recurring) tickets."
  task :tv => :environment do
    p 'lol wow tv scan'
  end
end
