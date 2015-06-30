# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "~/www/MakeCard/Backup/log/s.log"
#
every 1.day, at: "02:00" do
  command "backup perform -t makecard_backup -c ~/www/MakeCard/Backup/config.rb"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
