# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.

require 'rake'
# Be sure to change AppName to your application name!
Dc::Application.load_tasks

class Poll
  def perform
    Rake::Task['poll:set'].execute
  end
end

Crono.perform(Poll).every 1.hour, at: {min: 00}
Crono.perform(Poll).every 1.hour, at: {min: 30}