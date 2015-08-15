class JobsController < ApplicationController
  def index
    @jobs = Job.latest_jobs
  end

  def preview
    @job = Job.find_uncompleted(params[:id])
  end

  def complete
    @job = Job.find_uncompleted(params[:id])
    @job.completed_at = Time.now.utc
    @job.save
    redirect_to(@job)
  end

  def show
    @job = Job.find_completed(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      return redirect_to preview_job_path(@job) if @job.completed_at
      redirect_to @job
    else
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :address, :description, :apply_process,
                                :company_name, :company_url, :company_email)
  end
end
