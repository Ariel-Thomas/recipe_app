class FavoritesController < AuthorizationController
  def create
    @user = User.find(params[:recipe_id])
    @recipe = Recipe.find(params[:recipe_id])

    @user.favorites.create!(recipe: @recipe)
    
    redirect_to @recipe
  end

  def destroy
    @recipe = @favorite.recipe
    @favorite.destroy
    redirect_to @recipe
  end
end