class DiscountsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :load_discount, except: %i(index new create)

  def index
    @pagy, @discounts = pagy(Discount.get_discount, items: Settings.pages.page_number)
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = Discount.new discount_params

    if @discount.save
      flash[:success] = t("messages.create_success", name: @discount.titleize_name)
      redirect_to discounts_path
    else
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @discount.update_attributes discount_params
      flash[:success] = t("messages.update_success", name: @discount.titleize_name)
      redirect_to discounts_path
    else
      flash.now[:warning] = t "messages.update_failed"
      render :edit
    end
  end

  def destroy
    @discount.destroy
    if @discount.destroyed?
      respond_to :js
    else
      flash[:warning] = t("messages.delete_failed", name: @discount.titleize_name)
      redirect_to discounts_path
    end
  end

  private
  def discount_params
    params.require(:discount).permit Discount::DISCOUNT_PARAMS
  end

  def load_discount
    @discount = Discount.find_by id: params[:id]

    return if @discount

    flash[:notice] = t("messages.not_exists", name: Discount.name)
    redirect_to discounts_path
  end
end
