require_relative('../models/booking')

get '/bookings' do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

get '/bookings/new' do
  @gymclasses = GymClass.all()
  # for each gymclass, if the class is not full, add to the available classes array
  @available_classes = []

  for gymclass in @gymclasses
    if !gymclass.check_class_is_full
      @available_classes << gymclass
    end
  end

  @members = Member.all()
  erb(:"bookings/new")
end

get '/bookings/removebooking' do
  @booking = Booking.all()
  erb(:"bookings/removebooking")
end

post '/bookings' do
  @booking = Booking.new(params)
  @booking.save
  redirect('/bookings')
end

post '/bookings/delete' do
  @booking.delete()
  redirect('/bookings')
end
