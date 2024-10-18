require "sinatra"
require "sinatra/reloader"

get("/") do
  # add homepage using erb 
  erb(:homepage)
end
