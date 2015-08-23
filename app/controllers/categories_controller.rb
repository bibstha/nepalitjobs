class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    render layout: "front_page"
  end
end
