namespace :scan do
  desc 'Perform all scans'
  task :all do
    Rake.application.tasks.each do |task|
      task.invoke if task.name.starts_with?('scan:')
    end
  end
end

namespace :convert do
  desc 'Performs all conversions (takes a long time!)'
  task :all do
    Rake.application.tasks.each do |task|
      task.invoke if task.name.starts_with?('convert:')
    end
  end
end
