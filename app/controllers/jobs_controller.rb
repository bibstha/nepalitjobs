class JobsController < ApplicationController
  def index
    @jobs = Job.latest_jobs || []
    render layout: "front_page"
  end

  def search
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
    @job.category_id = Category.find_by_name("Design").id
  end

  def edit
    @job = Job.find_uncompleted(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      return redirect_to preview_job_path(@job)
    else
      render :new
    end
  end

  def update
    job = Job.find_uncompleted(params[:id])
    job.update!(job_params)
    redirect_to(preview_job_path(job))
  end

  private

  def job_params
    params.require(:job).permit(:title, :address, :description, :apply_process,
                                :company_name, :company_url, :company_email, :category_id)
  end
end
