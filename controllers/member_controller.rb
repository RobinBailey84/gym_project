get '/members' do
  @members = Member.all()
  erb(:"members/index")
end

get '/members/new' do
  @members = Member.all()
  erb(:"members/new")
end

get '/members/:id' do
  @member = Member.find(params[:id].to_i())
  erb(:"members/showmember")
end

post '/members' do
  @members = Member.new(params)
  @members.save()
  redirect('/members')
end
