# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"

every 1.day, at: '5:00 am' do
  runner 'site=DrugSite.new;site.keep_upcoming_event_alive'
end