require 'unirest'

require_relative "controllers/recipes_controller"
require_relative "views/recipes_views"
require_relative "models/recipe"



class Frontend
  while true
    def run

    system "clear"

    puts "Welcome to my Cookbook App"
    puts "make a selection"
    puts "    [1] See all recipes"
    puts "       -[1.1] Search all recipes"
    puts "       -[1.1] Sort Recipes by Chef"
    puts "       -[1.3] Sort Recipes by Prep Time"
    puts "    [2] See one recipe"
    puts "    [3] Create a new recipe"
    puts "    [4] Update a recipe"
    puts "    [5] Destroy a recipe"
    puts "    [signup] Signup for an account"
    puts "    [login] Login (create a JSON web token)"
    puts "    [logout] Logout (erases the JSON web token)"
    puts "    [q] Quit"

    input_option = gets.chomp

    if input_option == "1"
      recipes_index_action

    elsif input_option == "1.1"
      print "Enter a search term: "
      search_term = gets.chomp

      response = Unirest.get("http://localhost:3000/recipes?search=#{search_term}")
      products = response.body
      puts JSON.pretty_generate(products)

    elsif input_option == "1.2"
      response = Unirest.get("http://localhost:3000/recipes?sort=chef")
      products = response.body
      puts JSON.pretty_generate(products)

    elsif input_option == "1.3"
      response = Unirest.get("http://localhost:3000/recipes?sort=prep_time")
      products = response.body
      puts JSON.pretty_generate(products)

    elsif input_option == "2"
      recipes_show_action

    elsif input_option == "3"
      recipes_create_action

    elsif input_option == "4"
      recipes_update_action

    elsif input_option == "5"
      recipes_destroy_action

    elsif input_option == "signup"
      puts "Signup for a new account"
      puts
      client_params = {}

      print "Name: "
      client_params[:name] = gets.chomp

      print "Email: "
      client_params[:email] = gets.chomp

      print "Password: "
      client_params[:password] = gets.chomp

      print "Password Confirmation: "
      client_params[:password_confirmation] = gets.chomp

      json_data = post_request("/users", client_params) 
      puts JSON.pretty_generate(json_data)

    elsif input_option == "login"
      puts "Login"
      puts
      print "Email: "
      input_email = gets.chomp

      print "Password: "
      input_password = gets.chomp

      response = Unirest.post(
                              "http:/localhost:3000/user_tokenpe jc",
                              parameters: {
                                            auth: {
                                                    email: input_email,
                                                    password: input_password
                                                    }
                                            }
                              )
      puts JSON.pretty_generate(response.body)
      jwt = response.body["jwt"]
      Unirest.default_header("Authorization", "Bearer #{jwt}")

    elsif input_option == "logout"
      jwt = ""
      Unirest.clear_default_headers
      

    elsif input_option == "q"
      puts "Thanks for using the app"
      exit
    end
    
    gets.chomp
    
    end
  end
  private
    def get_request(url, client_params={})
      Unirest.get("http://localhost:3000#{url}", parameters: client_params).body
    end

    def post_request(url, client_params={})
      Unirest.post("http://localhost:3000#{url}", parameters: client_params).body
    end

    def patch_request(url, client_params={})
      Unirest.patch("http://localhost:3000#{url}", parameters: client_params).body
    end

    def delete_request(url, client_params={})
      Unirest.delete("http://localhost:3000#{url}", parameters: client_params).body
    end

end


