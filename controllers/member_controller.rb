get '/members' do
  @members = Member.all()
  erb(:"members/index")
end

get '/members/new' do
  @members = Member.all()
  erb(:"members/new")
end

post '/members' do
  @members = Member.new(params)
  @members.save()
  redirect('/members')
end
