load 'rmContacts.rb'
require 'sinatra'
require 'test/unit'
require 'rack/test'
require 'shoulda'
require 'rest-client'

load 'rmContactFiles.rb'

ENV['RACK_ENV'] = 'test'
class RmContactsTest <  Test::Unit::TestCase

  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  context "User save" do
  
  setup do
  end
  
  should "Home page" do
  get '/'
  assert last_response.ok?
  assert last_response.body.include? "Its working..."
  end
  
  should "say email and name are blank" do
  post '/users', { }
  
  user_hash = JSON.parse last_response.body
  assert !user_hash['persisted?']
  assert_contains user_hash['errors'], 'Email is invalid'
  assert_contains user_hash['errors'], "Name can't be blank"
  end
  
  should "say email and name are blank (1)" do
  post '/users', { :user => nil }
  
  user_hash = JSON.parse last_response.body
  assert !user_hash['persisted?']
  assert_contains user_hash['errors'], 'Email is invalid'
  assert_contains user_hash['errors'], "Name can't be blank"
  end
  
  should "say email and name are blank (2)" do
  post '/users', { :user => { } }
  
  user_hash = JSON.parse last_response.body
  assert !user_hash['persisted?']
  assert_contains user_hash['errors'], 'Email is invalid'
  assert_contains user_hash['errors'], "Name can't be blank"
  end
  
  should "say email in valid" do
  params = { :user => { :name => 'Test', :dob => Date.today, :email => 'test' } }
  post '/users', params
  
  user_hash = JSON.parse last_response.body
  assert !user_hash['persisted?']
  assert_equal user_hash['errors'].first, 'Email is invalid'
  end
  
  should "be created" do
  params = { :user => { :name => 'Test', :dob => Date.today, :email => 'test@gmail.com' } }
  post '/users', params
  
  user_hash = JSON.parse last_response.body
  assert last_response.ok?
  assert user_hash['persisted?']
  assert not( user_hash['id'].blank? )
  assert_equal user_hash['name'], params[:user][:name]
  assert not( user_hash['dob'].blank? )
  assert_equal user_hash['email'], params[:user][:email]
  end
  end

  context "Users' contact save" do

    setup do
      @user = User.create(:name => "test-#{Time.now}", :email => "test+#{User.last.id}@rmcontact.com")
    end

    should "not say anything - empty array" do
      post "/users/#{@user.id}/contacts", { :contacts => nil }
      # post "/users/#{@user.id}/contacts", { :contacts => [ { :label => 'labbl', :number => 'sdfda' }, { :label => 'labbl', :number => 'sdfda' } ] }

      contacts_hash = JSON.parse last_response.body

      assert last_response.ok?
      assert contacts_hash['contacts'].first.blank?
    end

    should "not say anything - array with nil element" do
      post "/users/#{@user.id}/contacts", { :contacts => [nil, nil] }
      # post "/users/#{@user.id}/contacts", { :contacts => [ { :label => 'labbl', :number => 'sdfda' }, { :label => 'labbl', :number => 'sdfda' } ] }

      contacts_hash = JSON.parse last_response.body

      assert last_response.ok?
      assert contacts_hash['contacts'].first.blank?
    end

    should "not say anything - array with empty hash" do
      post "/users/#{@user.id}/contacts", { :contacts => [{}, {}] }
      # post "/users/#{@user.id}/contacts", { :contacts => [ { :label => 'labbl', :number => 'sdfda' }, { :label => 'labbl', :number => 'sdfda' } ] }

      contacts_hash = JSON.parse last_response.body

      assert last_response.ok?
      assert contacts_hash['contacts'].first.blank?
    end

    should "be saved successfully" do
      post "/users/#{@user.id}/contacts", { :contacts => [ { :label => 'labbl', :number => 'sdfda' }, { :label => 'labbl', :number => 'sdfda' } ] }

      contacts_hash = JSON.parse last_response.body

      contact = contacts_hash['contacts'].first
      assert contact['persisted?']
      assert !contact['id'].blank?
      assert !contact['label'].blank?
      assert !contact['number'].blank?

      contact = contacts_hash['contacts'].last
      assert contact['persisted?']
      assert !contact['id'].blank?
      assert !contact['label'].blank?
      assert !contact['number'].blank?

      assert last_response.ok?
    end

  end
end