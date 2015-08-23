class AdminController < ApplicationController
  layout "admin"
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  def list_jobs
    @jobs = Job.list_all
  end

  def publish
    job = Job.find_completed(params[:admin_job_id])
    job.publish
    redirect_to(:admin_list_jobs)
  end

  def unpublish
    job = Job.find_completed(params[:admin_job_id])
    job.unpublish
    redirect_to(:admin_list_jobs)
  end

  def show
    @job = Job.find(params[:id])
    render "jobs/show"
  end

  def destroy
    Job.destroy(params[:id])
    redirect_to(:admin_list_jobs)
  end
end
