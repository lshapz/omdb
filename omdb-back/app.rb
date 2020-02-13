require 'sinatra'
require 'sinatra/activerecord'
require './models/movie'
require 'sinatra/json'
# set :database, {adapter: 'postgresql', database: 'development'}
mime_type :json, 'application/json'

require_relative 'config/environment'
require "sinatra/cors"

set :allow_origin, "*"
set :allow_methods, "GET,HEAD,POST,PUT,DELETE"
set :allow_headers, "content-type,if-modified-since"
set :expose_headers, "location,link"

class App < Sinatra::Base

  get '/' do 
     "Started my server using shotgun!"
  end
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  before do
   content_type :json
  end
  helpers do
   def json( dataset )
    if !dataset #.empty?
     return no_data!
    else
     JSON.pretty_generate(JSON.load(dataset.to_json))
    end
   end

   def no_data!
    status 204
    #json :message => 'no data'
   end

   def search(title)
    @title = title
    @movie = Movie.find_by title(@title)
    json @movie
   end
  end
  
  get '/movies/' do
   @movies = Movie.all
   json @movies
  end

  get '/movies/:id' do
   @movies = Movie.find(params[:id])
   json @movies
  end

  
  get '/movies/search/:title' do
   search(params[:title])
  end
  
  post '/movies' do
   new_post = MultiJson.load(request.body.read)
   puts request.body
   @movie = Movie.new( new_post )
   if @movie.save
      json @movie
   else
      no_data!
   end
  end

  put '/movies/:id' do
   @movie = Movie.find(params[:id])
   if !@movie
      no_data!
   else
      puts request.body
      update_post = MultiJson.load request.body.read
   if @movie.update_attributes(update_post)
      json @movie
   else
      json @movie.errors.messages
   end
   end
  end
  delete '/movies/delete/:id' do
   @movie = Movie.find_by_id params[:id]
   if !@movie
      no_data!
   else
      @movie.destroy
   end
  end
  
end
