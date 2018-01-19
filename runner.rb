require 'unirest'

system "clear"

puts "Welcome to my Cookbook App"
puts "make a selection"
puts "    [1] See all recipes"
puts "    [2] See one recipe"
puts "    [3] Create a new recipe"
puts "    [4] Update a recipe"
puts "    [5] Destroy a recipe"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/recipes")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "2"
  print "Enter recipe id: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/recipes/#{input_id}")
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "3"
  client_params = {}

  print "Title: "
  client_params[:title] = gets.chomp

  print "Chef: "
  client_params[:chef] = gets.chomp

  print "Ingredients: "
  client_params[:ingredients] = gets.chomp

  print "Directions: "
  client_params[:directions] = gets.chomp

  response = Unirest.post(
                          "http://localhost:3000/recipes",
                          parameters: client_params
                          )
  recipe_data = response.body

  puts JSON.pretty_generate(recipe_data)


elsif input_option == "4"
  client_params = {}
  print "Enter recipe id: "
  input_id = gets.chomp

  print "Title: "
  client_params[:title] = gets.chomp

  print "Chef: "
  client_params[:chef] = gets.chomp

  print "Ingredients: "
  client_params[:ingredients] = gets.chomp

  print "Directions: "
  client_params[:directions] = gets.chomp


  response = Unirest.patch(
                          "http://localhost:3000/recipes/#{input_id}",
                          parameters: client_params
                          )
  recipe_data = response.body

  puts JSON.pretty_generate(recipe_data)
elsif input_option == "5"
  print "Enter recipe id: "
  input_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/recipes/#{input_id}")

  data = response.body
  puts JSON.pretty_generate(data["message"])
end
    














