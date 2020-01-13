class VouchersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: :index
  before_action :load_discount, only: [:new, :create]
  before_action :check_voucher_params, :check_list_user, only: :create

  def index
    @vouchers = current_user.vouchers
  end

  def new
    @voucher = Voucher.new
  end

  def create
    flag = true

    ActiveRecord::Base.transaction do
      params[:user_ids].each do |u|
        user = User.find_by id: u
        if user.nil?
          flag = false
          raise ActiveRecord::Rollback
        end
        @voucher = Voucher.find_or_initialize_by(user_id: u, discount_id: @discount.id, start_time: params[:voucher][:start_time], end_time: params[:voucher][:end_time])
        @voucher.number = @voucher.number + 1
        @voucher.save!
      end
    end

    if flag
      flash[:success] = t("messages.create_success", name: Voucher.name)
      redirect_to discounts_path
    else
      flash[:danger] = flash.now[:danger] = t "messages.create_failed"
      render :new, params: {discount_id: @discount.id}
    end
  end

  private
  def voucher_params
    params.require(:voucher).permit Voucher::VOUCHER_PARAMS
  end

  def check_list_user
    return if params[:user_ids].present?

    flash[:danger] = t "messages.create_failed"
    redirect_to new_discount_voucher_path(params[:discount_id])
  end

  def load_discount
    @discount = Discount.find_by id: params[:discount_id]

    return if @discount

    flash[:danger] = t("messages.not_exists", name: Discount.name)
    redirect_to discounts_path
  end

  def check_voucher_params
    return if params[:voucher].present?

    flash[:danger] = flash.now[:danger] = t "messages.create_failed"
    redirect_to discounts_path
  end
end
