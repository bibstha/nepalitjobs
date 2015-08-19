class JobMailer < ActionMailer::Base
  add_template_helper(PathHelper)

  default from: "bibekshrestha@gmail.com"

  def confirm_email(job)
    @job = job
    mail(to: job.company_email, subject: "Confirm your ad posting")
  end
end
