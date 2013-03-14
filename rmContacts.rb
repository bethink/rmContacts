load 'rmContactFiles.rb'

get '/ping' do
  "Its working... :)"
end

#{
#    :user_id => 555,
#    :email => 'manojs.nitt@gmail.com',
#    :password => 'password',
#    :contacts => [
#        {
#            :mobile_reference => 333,
#            :display_name => 'me',
#            :messages_attributes => [
#                    {
#                        :message => "Hi...",
#                        :time_received => "1358538770262"
#                    }
#                ]
#        }
#    ]
#}

post '/update_messages' do

  puts "======================="
  puts params.inspect
  puts params[:email].inspect
  puts params["email"].inspect
  puts params[:contacts].length.inspect
  puts "======================="

  @user = User.find_by_id(params[:user_id])

  if @user
    @user.update_messages(params[:contacts])
  else
    @user = User.new email: params[:email], password: params[:password]

    if @user.save
      @user.update_messages(params[:contacts])
    end
  end rescue

  render :json => { :status => 'Succs' }.to_json
end


# params = {:user => {:name => 'name',:dob => Date.today,:email => 'name'}}
# RestClient.post 'localhost:4567/users', params, :content_type => :json, :accept => :json

post '/users' do

  user = User.new(params[:user])

  if user.save
    attrs = user.attributes
    attrs[:persisted?] = true
    attrs.to_json
  else
    {:persisted? => false, :errors => user.errors.full_messages}.to_json
  end
end

post '/users/:id/contacts' do

  user = User.find(params[:id])

  contacts_input = (params[:contacts] || [])
  contacts_input.collect! { |contact| contact.blank? ? nil : contact }.compact!

  contacts = contacts_input.collect do |contact|
    user.contacts.create(contact)
  end

  contact_response = contacts.collect do |contact|
    attrs = contact.attributes
    attrs[:persisted?] = !contact.new_record?
    attrs
  end
  {:contacts => contact_response}.to_json
end

put '/contact' do
  user = User.find(params[:id])

  user.save ? user.to_json : {:status => false}
end

get '/contact/:id' do
  user = User.find_by_id(params[:id])
  user.to_json unless user.blank?
end

