load 'rmContactFiles.rb'
require 'ruby-debug'

get '/' do
  users = User.all
  "Its working... :)       #{users.inspect}"
end

# params = {:user => {:name => 'name',:dob => Date.today,:email => 'name'}}
# RestClient.post 'localhost:4567/users', params, :content_type => :json, :accept => :json

post '/users' do

  user = User.new( params[:user] )

  if user.save
    attrs = user.attributes
    attrs[:persisted?] = true
  attrs.to_json
  else
    { :persisted? => false, :errors => user.errors.full_messages }.to_json
  end
end

post '/users/:id/contacts' do

  user = User.find( params[:id] )

  contacts_input = ( params[:contacts] || [] )
  contacts_input.collect!{|contact| contact.blank? ? nil : contact  }.compact!

  contacts = contacts_input.collect do |contact|
    user.contacts.create( contact )
  end

  contact_response = contacts.collect do |contact|
    attrs = contact.attributes
    attrs[:persisted?] = !contact.new_record? 
    attrs
  end
  { :contacts => contact_response }.to_json
end

put '/contact' do
  user = User.find(params[:id])

  user.save ? user.to_json : { :status => false }
end

get '/contact/:id' do
  user = User.find_by_id( params[:id] )
  user.to_json unless user.blank?
end

