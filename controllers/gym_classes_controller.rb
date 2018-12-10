require_relative('../models/gymclass')

get '/gymclasses' do
  @gymclasses = GymClass.all()
  erb(:"classes/index")
end

get '/gymclasses/new' do
  @gymclasses = GymClass.all()
  erb(:"classes/new")
end

get '/classes/:id' do
  @gymclass = GymClass.find(params[:id].to_i())
  erb(:"classes/showclass")
end

post '/gymclasses' do
  @gymclasses = GymClass.new(params)
  @gymclasses.save()
  redirect('/gymclasses')
end

post '/gymclasses/:id/delete' do
  @gymclass = GymClass.find(params[:id].to_i())
  @gymclass.delete()
  redirect('/gymclasses')
end

get '/gymclasses/:id/edit' do
  @gymclass = GymClass.find(params[:id].to_i())
  erb(:"classes/edit")
end

post '/gymclasses/:id' do
  @gymclass = GymClass.new(params)
  @gymclass.update()
  redirect('/gymclasses')
end

get '/gymclasses/:id/view' do
  @gymclass = GymClass.find(params[:id].to_i())
  erb(:"classes/view")
end
