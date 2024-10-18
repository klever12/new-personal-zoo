require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  # add homepage using erb
  erb(:homepage)
end

get("/animal_added") do
  # get string query variables provided by user with animal choice and name
  @user_choice = params.fetch("user_choice")
  @user_name = params.fetch("user_name")

  # set api url based on the animal choice the user made
  if @user_choice == "dog"
    api_url = "https://random.dog/woof.json"
  elsif @user_choice == "fox"
    api_url = "https://randomfox.ca/floof/"
  else
    api_url = "https://random-d.uk/api/v2/random"
  end

  # get response using HTTP get
  raw_response = HTTP.get(api_url)

  # convert response to string
  raw_string = raw_response.to_s

  # parse raw string to convert to hash
  parsed_data = JSON.parse(raw_string)

  # based on animal user choice, get image url from parsed data
  if @user_choice == "dog"
    @image_url = parsed_data.fetch("url")
  elsif @user_choice == "fox"
    @image_url = parsed_data.fetch("image")
  else
    @image_url = parsed_data.fetch("url")
  end

  # add animal_added page using erb
  erb(:animal_added)
end
