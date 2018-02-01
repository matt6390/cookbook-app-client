module RecipesController
  def recipes_index_action
    recipe_hashs = get_request("/recipes")
    recipes = Recipe.convert_hashs(recipe_hashs)
    recipes_index_view(recipes)
  end

  def recipes_show_action
    input_id = recipes_id_form
    recipe_hash = get_request("/recipes/#{input_id}")
    recipe = Recipe.new(recipe_hash)

    recipes_show_view(recipe)
  end

  def recipes_create_action
    client_params = recipes_new_form
    json_data = post_request("/recipes", client_params)

    if !json_data["errors"]
      recipe = Recipe.new(json_data)
      recipes_show_view(recipe)
    else
      errors = json_data["errors"]
      recipes_errors_view(errors)
    end
  end

  def recipes_update_action
    input_id = recipes_id_form
    recipe_hash = get_request("/recipes/#{input_id}")
    recipe = Recipe.new(recipe_hash)

    client_params = recipes_update_form(recipe)
    json_data = patch_request("/recipes/#{input_id}", client_params)

    if !json_data["errors"]
      recipe = Recipe.new(json_data)
      recipes_show_view(recipe)
    else
      errors = json_data["errors"]
      recipes_errors_view(errors)
    end
  end

  def recipes_destroy_action
    input_id = recipes_id_form
    json_data = delete_request("/recipes/#{input_id}")
    puts json_data["message"]
  end
end