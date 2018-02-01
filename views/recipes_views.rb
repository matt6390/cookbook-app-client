module RecipesViews
  def recipes_index_view(recipes)
    puts "*" * 70
    recipes.each do |recipe|
      recipes_show_view(recipe)
      puts "*" * 70
    end
  end

  def recipes_show_view(recipe)
    puts 
    puts recipe.title.upcase
    puts "=" * 70
    puts "by: #{recipe.chef}".ljust(35) + "prep: #{recipe.prep_time}".rjust(35)
    puts
    puts "Ingredients"
    puts "-" * 70
    recipe.ingredients.each do |ingredient|
      puts "    • #{ingredient}"
    end
    puts
    puts "Directions"
    puts "-" * 70
    recipe.directions.each_with_index do |direction, index|
      puts "    #{index + 1}. #{direction}"
    end
    puts
  end

  def recipes_id_form
    print "Enter recipe id: "
    gets.chomp
  end

  def recipes_new_form
    client_params = {}

    print "Title: "
    client_params[:title] = gets.chomp

    print "Ingredients: "
    client_params[:ingredients] = gets.chomp

    print "Directions: "
    client_params[:directions] = gets.chomp

    print "Prep Time: "
    client_params[:prep_time] = gets.chomp

    client_params
  end

  def recipes_update_form(recipe)
    client_params = {}

    print "Title (#{recipe.title}): "
    client_params[:title] = gets.chomp

    print "Chef (#{recipe.chef}): "
    client_params[:chef] = gets.chomp

    print "Ingredients (#{recipe.ingredients}): "
    client_params[:ingredients] = gets.chomp

    print "Directions (#{recipe.directions}): "
    client_params[:directions] = gets.chomp

    print "Prep Time (#{recipe.prep_time}): "
    client_params[:prep_time] = gets.chomp

    client_params.delete_if { |key, value| value.empty? }
    client_params
  end
end