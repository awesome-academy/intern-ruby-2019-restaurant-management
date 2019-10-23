class StaticPagesController < ApplicationController
  def home
    @posts = Post.select(:id, :title).order(:title).limit(8)
    @foods = Food.check_food
  end

  def help; end
end
