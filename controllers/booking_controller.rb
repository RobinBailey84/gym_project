require_relative('../models/booking')
#bookings homepage
get '/bookings' do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

#takes you to book a member to class
get '/bookings/new' do
  @members = Member.all()
  erb(:"bookings/select")
end

post '/bookings/new' do
  @member = Member.save(params)
  redirect(:"booking/select")
end

post '/bookings' do
  @bookings = Booking.new(params)
  @bookings.save()
  redirect('/bookings')
end

# get '/bookings/new/:member_id'
# pass through the member id as a param
# find the member
# do logic to see if gold membership/peak time
get '/bookings/new/:member_id' do
  @member = Member.find(params[:member_id])
  @gymclasses = GymClass.all()
  @available_classes = []

  for gymclass in @gymclasses
    if @member.gold_membership == 'f' && gymclass.peak_time == 'f' && !gymclass.check_class_is_full
      @available_classes << gymclass
    elsif @member.gold_membership =='t' && !gymclass.check_class_is_full
      @available_classes << gymclass
    end
  end

  erb(:"bookings/new")
end




#deleting booking
get '/bookings/:id' do
  @bookings = Booking.find(params[:id].to_i())
  erb(:"bookings/removebooking")
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id].to_i())
  @booking.delete()
  redirect('/bookings')
end
