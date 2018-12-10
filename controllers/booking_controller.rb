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

get '/bookings/:id' do
  @bookings = Booking.find(params[:id].to_i())
  erb(:"bookings/removebooking")
end

post '/bookings' do
  @booking = Booking.new(params)
  @booking.save
  redirect('/bookings')
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id].to_i())
  @booking.delete()
  redirect('/bookings')
end
