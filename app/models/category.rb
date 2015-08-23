class Category < ActiveRecord::Base
  has_many :jobs

  def latest_jobs
    jobs.where.not(published_at: nil).order(published_at: :desc)
  end
end
