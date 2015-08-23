module PathHelper
  def preview_job_link_with_token(job, title)
    link_to(title, preview_job_url(job, edit_token: job.edit_token))
  end

  def publish_job_link_with_token(job, title, opts = {})
    link_to(title, publish_job_url(job, edit_token: job.edit_token), opts)
  end

  def email_verify_link_with_token(job, title)
    link_to(title, email_verify_job_url(job, token: job.email_verification_token))
  end

  def twitter_link
    name = Rails.configuration.twitter
    link_to("@#{name}", "https://twitter.com/#{name}")
  end
end
