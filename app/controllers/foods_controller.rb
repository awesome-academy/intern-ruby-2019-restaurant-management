class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: :index
  before_action :set_up, except: %i(new create index)

  def new
    @food = Food.new
  end

  def show; end

  def edit; end

  def index
    @pagy, @foods = pagy(Food.select(:id, :name, :description, :price, :cost).order(:name),
      items: Settings.pages.page_number)
  end

  def create
    @food = Food.new food_params

    if @food.save
      flash[:success] = t("messages.create_success", name: @food.titleize_name)
      redirect_to foods_path
    else
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def update
    if @food.update_attributes food_params
      flash[:success] = t("messages.update_success", name: @food.titleize_name)
      redirect_to foods_path
    else
      flash.now[:warning] = t "messages.update_failed"
      render :edit
    end
  end

  def destroy
    @food.destroy
    if @food.destroyed?
      respond_to :js
    else
      flash[:warning] = t("messages.delete_failed", name: @food.titleize_name)
      redirect_to foods_path
    end
  end

  private
  def food_params
    params.require(:food).permit Food::FOOD_PARAMS
  end

  def set_up
    @food = Food.find_by id: params[:id]

    return if @food

    flash[:warning] = t("messages.not_exists", name: Food.name)
    redirect_to foods_path
  end
end
