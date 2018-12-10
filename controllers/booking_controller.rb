get '/bookings' do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

get '/bookings/new' do
  @gymclasses = GymClass.all()
  # for each gymclass, if the class is not full, add to the available classes array
  @available_classes = @gymclasses.map{|available|GymClass.check_class_is_full(available)}
  @members = Member.all()
  erb(:"bookings/new")
end

post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect('/bookings')
end
