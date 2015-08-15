class JobsController < ApplicationController
  def index
    @jobs = Job.latest_jobs
  end

  def preview
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create

  end
end
