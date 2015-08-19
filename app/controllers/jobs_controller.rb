class JobsController < ApplicationController
  def index
    @jobs = Job.latest_jobs || []
    render layout: "front_page"
  end

  def search
    @jobs = Job.search(params[:search])
  end

  def preview
    @job = Job.find_by_id_and_edit_token!(params[:id], params[:edit_token])
  end

  def complete
    @job = Job.find_by_id_and_edit_token!(params[:id], params[:edit_token])
    @job.complete
    flash[:notice] = "We have sent you an email at #{@job.company_email} with a link to Publish this ad. You must" \
      " click the link for this Ad to appear in our homepage."
    redirect_to(preview_job_path(@job, edit_token: params[:edit_token]))
  end

  def email_verify
    @job = Job.find_by_id_and_email_verification_token!(params[:id], params[:token])
    @job.publish
    flash[:notice] = "Your Ad has been published."
    redirect_to(@job)
  end

  def show
    @job = Job.find_published(params[:id])
  end

  def new
    @job = Job.new
    @job.category_id = Category.find_by_name("Design").id
  end

  def edit
    @job = Job.find_by_id_and_edit_token!(params[:id], params[:edit_token])
  end

  def create
    @job = Job.new(job_params)
    @job.edit_token = SecureRandom.uuid

    if @job.save
      return redirect_to preview_job_path(@job, edit_token: @job.edit_token)
    else
      render :new
    end
  end

  def update
    job = Job.find_by_id_and_edit_token!(params[:id], params[:job][:edit_token])
    job.update!(job_params)
    redirect_to(preview_job_path(job, edit_token: job.edit_token))
  end

  private

  def job_params
    params.require(:job).permit(:title, :address, :description, :apply_process,
                                :company_name, :company_url, :company_email, :category_id)
  end
end
