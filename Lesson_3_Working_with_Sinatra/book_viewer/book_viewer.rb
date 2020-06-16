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

def each_chapter
  @table_of_contents.each_with_index do |name, index|
    number = index + 1
    contents = File.read("data/chp#{number}.txt")
    yield number, name, contents
  end
end

def chapters_matching(query)
  results = []

  return results if !query || query.empty?

  each_chapter do |number, name, contents|
    results << {number: number, name: name} if contents.include?(query)
  end
  
  results
end

get '/search' do
  @results = chapters_matching(params[:query])
  erb :search
end

