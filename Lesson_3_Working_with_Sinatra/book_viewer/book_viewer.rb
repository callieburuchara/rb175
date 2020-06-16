require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

before do
  @table_of_contents = File.readlines("data/toc.txt")
end

helpers do
  def in_paragraphs(text)
    text = text.split("\n\n")
    text.map { |line| "<p>#{line}</p>" }.join
  end
end

not_found do
  redirect '/'
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  erb :home
end

get '/chapters/:number' do
  number = params[:number].to_i
  redirect "/" unless (1..@table_of_contents.size).include?(number)

  @contents = in_paragraphs(File.read("data/chp#{number}.txt"))
  
  name = @table_of_contents[number - 1]
  @chapter_title = "Chapter #{number}: #{name}"


  erb :chapter
end
