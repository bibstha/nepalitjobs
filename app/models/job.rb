class Job < ActiveRecord::Base
  def self.latest_jobs(all: false)
    jobs = where(expired: false).order(published_at: :desc)
    jobs.limit(30) if all
  end
end
