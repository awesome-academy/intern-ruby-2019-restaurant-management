module BookingsHelper
  def check_hour? hour
    hour < 23 && hour > 7
  end

  def list_people table_type
    number = Table.type_tables[table_type]
    Booking.people.keys[0..number]
  end

  def check_unpaid? booking
    booking.unpaid? && (current_user == booking.user || current_user.admin?)
  end
end
