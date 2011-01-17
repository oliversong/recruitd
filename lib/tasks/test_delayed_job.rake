require 'delayed_job'
#require File.expand_path("test/factories/factories.rb")

namespace :db do
  namespace :data do 
  
    desc "Load sample data"
    task :test_dj => :environment do |t|
      Delayed::Job.enqueue UpdateRecommendationsJob.new('Company',2)
      Delayed::Job.enqueue ProcessFeedbackJob.new('Company',1,'Student',1,ProcessFeedbackJob::STAR)
    end
  end
end

