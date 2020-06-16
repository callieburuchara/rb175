require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  @table_of_contents = File.readlines('data/toc.txt')
  
  erb :home
end

get '/chapters/:number' do
  number = params[:number]
  @table_of_contents = File.readlines('data/toc.txt')
  @contents = File.read("data/chp#{number}.txt")
  
  name = @table_of_contents[number.to_i - 1]
  @chapter_title = "Chapter #{number}: #{name}"


  erb :chapter
end
