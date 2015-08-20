class Job < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid

  belongs_to :category
  validates_presence_of(:title, :address, :description, :apply_process,
                        :company_name, :company_url, :company_email)

  class << self
    def latest_jobs
      where(expired: false).where.not(published_at: nil).order(published_at: :desc)
      # jobs.limit(30) if all
    end

    def find_published(id)
      where(id: id).where.not(published_at: nil).first || raise(ActiveRecord::RecordNotFound)
    end

    def list_all
      order(published_at: :desc)
    end
  end

  def complete
    update(email_verification_token: SecureRandom.uuid)
    JobMailer.confirm_email(self).deliver!
  end

  def publish
    update!(email_status: "verified", published_at: Time.now.utc)
  end

  def unpublish
    self.update!(published_at: nil)
  end

  def expire
    self.update!(expired: true)
  end

  def unexpire
    self.update!(expired: false)
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
