class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_table, only: %i(new create)
  before_action :check_hour, only: :create

  def index
    booking = current_user.admin? ? Booking.get_booking : current_user.books
    @pagy, @bookings = pagy(booking, items: Settings.pages.page_number)
  end

  def new
    @booking = Booking.new
    @users = User.get_user
  end

  def create
    if !Booking.check_book_exsits(params[:table_id], params[:booking][:book_at]).present?
      @booking = @table.books.new booking_params
      @booking.user_id = current_user.admin? ? User.find_by(email: params[:user_email]).id : current_user.id
      if @booking.save
        flash[:success] = t("messages.create_success", name: @booking.book_at)
        redirect_to tables_path
      else
        render :new
      end
    else
      @booking = Booking.new
      @users = User.get_user
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private
  def booking_params
    params.require(:booking).permit Booking::BOOKING_PARAMS
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]

    return if @booking

    flash[:warning] = t(:massage_not_exsits)
    redirect_to show_booking_path
  end

  def load_table
    @table = Table.find_by id: params[:table_id]

    return if @table

    flash[:warning] = t("messages.not_exists", name: Table.name)
    redirect_to tables_path
  end

  def check_hour
    hour = params[:booking][:book_at].to_time.hour

    return if hour < 23 && hour > 7

    flash[:warning] = t "messages.hour_failed"
    redirect_to :new
  end
end
