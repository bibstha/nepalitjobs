class Job < ActiveRecord::Base
  validates_presence_of(:title, :address, :description, :apply_process,
                        :company_name, :company_url, :company_email)

  def self.latest_jobs(all: false)
    jobs = where(expired: false).order(published_at: :desc)
    jobs.limit(30) if all
  end

  def self.find_uncompleted(id)
    where(id: id, completed_at: nil).first || raise(ActiveRecord::RecordNotFound)
  end

  def self.find_completed(id)
    where(id: id).where.not(completed_at: nil).first || raise(ActiveRecord::RecordNotFound)
  end
end
