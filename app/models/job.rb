class Job < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_paranoid

  belongs_to :category
  validates_presence_of(:title, :address, :description, :apply_process,
                        :company_name, :company_url, :company_email)
  validates_format_of(:company_email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i)

  class << self
    def latest_jobs
      where.not(published_at: nil).order(published_at: :desc)
      # jobs.limit(30) if all
    end

    def find_published(id)
      where(id: id).where.not(published_at: nil).first || raise(ActiveRecord::RecordNotFound)
    end

    def list_all
      order(published_at: :desc)
    end

    def search(term)
      require "html/sanitizer"
      sanitized_term = HTML::FullSanitizer.new.sanitize(term)
      __elasticsearch__.search(sanitized_term).records.to_a.delete_if { |job| job.published_at.nil? }
    end
  end

  def email_verified?
    email_status == "verified"
  end

  # A user marks his job as 'ready'
  def send_verification_email
    update!(email_status: "sent", email_verification_token: SecureRandom.uuid)
    JobMailer.confirm_email(self).deliver!
  end

  # A user has verified his email and decideds to publish it
  def publish
    update!(email_status: "verified", published_at: Time.now.utc)
  end

  def unpublish
    self.update!(published_at: nil)
  end

  def description_pretty
    markdown = Redcarpet::Markdown.new(safe_renderer, autolink: true)
    markdown.render(description)
  end

  def apply_process_pretty
    markdown = Redcarpet::Markdown.new(safe_renderer, autolink: true)
    markdown.render(apply_process)
  end

  def safe_renderer
    @safe_renderer ||= Redcarpet::Render::HTML.new(escape_html: true, no_images: true)
  end
end
