class CategoriesController < ApplicationController
  before_action :set_category, only: :destroy
  before_action :set_bubble, only: %i[ new create ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.find_or_create_by(category_params)
    @category.save

    @category.bubbles << @bubble
    redirect_to bubble_path(@bubble)
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_bubble
    @bubble = Bubble.find(params[:bubble_id])
  end
end
