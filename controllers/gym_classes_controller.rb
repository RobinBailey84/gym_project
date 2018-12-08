get '/gymclasses' do
  @gymclasses = GymClass.all()
  erb(:"classes/index")
end

get '/gymclasses/new' do
  @gymclasses = GymClass.all()
  erb(:"classes/new")
end

post '/gymclasses' do
  @gymclasses = GymClass.new(params)
  @gymclasses.save()
  redirect('/gymclasses')
end
