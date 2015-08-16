class Job < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :category
  validates_presence_of(:title, :address, :description, :apply_process,
                        :company_name, :company_url, :company_email)

  def self.latest_jobs
    where(expired: false).where.not(published_at: nil).order(published_at: :desc)
    # jobs.limit(30) if all
  end

  def self.find_uncompleted(id)
    where(id: id, completed_at: nil).first || raise(ActiveRecord::RecordNotFound)
  end

  def self.find_completed(id)
    where(id: id).where.not(completed_at: nil).first || raise(ActiveRecord::RecordNotFound)
  end

  def self.list_all
    order(completed_at: :desc)
  end

  def publish
    self.published_at = Time.now.utc
    save
  end

  def unpublish
    self.published_at = nil
    save
  end

  def expire
    self.expired = true
    save
  end

  def unexpire
    self.expired = false
    save
  end

  def incomplete
    self.completed_at = nil
    save
  end

  def publishable?
    completed_at? && !(published_at? || expired?)
  end

  def description_pretty
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(description)
  end

  def apply_process_pretty
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    markdown.render(apply_process)
  end
end
