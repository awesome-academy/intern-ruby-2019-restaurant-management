class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_table, only: %i(new create)
  before_action :check_booking_params, :check_hour, only: :create
  before_action :check_admin, :load_booking, only: :destroy

  def index
    booking = current_user.admin? ? Booking.get_booking : current_user.books
    @pagy, @bookings = pagy(booking, items: Settings.pages.page_number)
  end

  def new
    @booking = Booking.new
    @users = User.get_user_email
  end

  def create
    if !Booking.check_book_exsits(params[:table_id], params[:booking][:book_at]).present?
      @booking = @table.books.new booking_params
      @booking.user_id = current_user.admin? ? User.find_by(email: params[:user_selected]).id : current_user.id
      save_booking @booking
    else
      set_up_when_failed
    end
  end

  def destroy
    @booking.destroy

    if @booking.destroyed?
      respond_to :js
    else
      flash[:warning] = t("messages.delete_failed", name: @booking.book_at)
      redirect_to show_booking_path
    end
  end

  private
  def booking_params
    params.require(:booking).permit Booking::BOOKING_PARAMS
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]

    return if @booking

    flash[:warning] = t("messages.not_exists", name: Booking.name)
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

    return if hour.between?(Settings.models.bookings.min_hour, Settings.models.bookings.max_hour)

    flash[:warning] = t "messages.hour_failed"
    redirect_to :new
  end

  def save_booking booking
    if booking.save
      flash[:success] = t("messages.create_success", name: booking.book_at)
      redirect_to tables_path
    else
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def check_booking_params
    return if params[:booking].present?

    set_up_when_failed
  end

  def set_up_when_failed
    @booking = Booking.new
    @users = User.get_user_email
    flash.now[:warning] = t "messages.create_failed"
    render :new
  end
end
