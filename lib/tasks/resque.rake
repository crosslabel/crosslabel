require "resque/tasks"
require 'resque/scheduler/tasks'
namespace :resque do
  task :setup => :environment do

  end

  task :setup_product_trendiness => :setup do
    require 'resque_scheduler'

    Resque.schedule = YAML.load_file('resque_schedule.yml')

    require 'ProductTrendinessCalculator'
  end

  task :scheduler => :setup_product_trendiness
end
