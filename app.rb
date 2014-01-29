require 'bundler/setup'
Bundler.require()

require 'json'
require 'open-uri'


get '/' do
	@page_title = 'Home'
	erb :index
end

get '/search' do
	if params[:title] == ""
		redirect '/'
	end

	@page_title = "Search - #{params[:title]}"

	titleSearch = params[:title]
	file = open("http://omdbapi.com/?s=#{titleSearch}")
	@movies = JSON.load(file.read)["Search"]
	@movies = @movies.sort_by{ |h| h["Year"]}.reverse
	erb :results
end

get '/movies/' do
	
	idSearch = params[:id]
	file = open("http://omdbapi.com/?i=#{idSearch}")
	@movie = JSON.load(file.read)

	@page_title = @movie['Title']
	erb :movie
end