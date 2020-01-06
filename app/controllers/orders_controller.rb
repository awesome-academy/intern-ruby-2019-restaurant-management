class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, only: %i(edit update destroy)
  before_action :load_booking, only: %i(index create)

  def index
    @pagy, @orders = pagy(@booking.orders, items: Settings.pages.page_number)
  end

  def new
    @order = Order.new
  end

  def create
    @order = @booking.orders.new order_params
    @order.food_id = params[:order][:food_id]

    if @order.save
      flash[:success] = t("messages.create_success", name: @order.food_name_titleize)
      redirect_to booking_orders_path(@booking.id)
    else
      flash.now[:danger] = t "messages.create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @order.update_attributes order_params
      flash[:success] = t("messages.update_success", name: @order.food_name_titleize)
      redirect_to booking_orders_path(@order.booking.id)
    else
      flash.now[:danger] = t "messages.update_failed"
      render :edit
    end
  end

  def destroy
    @order.destroy
    if @order.destroyed?
      respond_to :js
    else
      flash[:danger] = t("messages.delete_failed", name: @order.food_name_titleize)
      redirect_to show_booking_path
    end
  end

  private
  def load_order
    @order = Order.find_by id: params[:id]

    return if @order

    flash[:danger] = t("messages.not_exists", name: Order.name)
    redirect_to show_booking_path
  end

  def load_booking
    @booking = Booking.find_by id: params[:booking_id]

    return if @booking

    flash[:danger] = t("messages.not_exists", name: Booking.name)
    redirect_to show_booking_path
  end

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end
end
