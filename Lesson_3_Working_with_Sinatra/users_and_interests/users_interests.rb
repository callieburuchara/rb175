require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require 'yaml'

before do
  @all_users = YAML.load_file('users.yaml')
  @interests_amount = count_interests(@all_users)
  @user_amount = @all_users.size
end

helpers do
  def count_interests(all_users)
    counter = 0
    
    all_users.each do |key, value|
      counter += value[:interests].size
    end
    counter
  end
end

get '/' do
  redirect '/all-users'
end

get '/all-users' do
  erb :all_users  
end

get '/users/:name' do 
  @name = request.path_info.split('/')[-1].capitalize
  @key_name = @name.downcase.to_sym
  erb :each_user
end