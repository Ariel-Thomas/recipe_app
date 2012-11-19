class FavoritesController < AuthorizationController

  def create
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:recipe_id])

    @user.favorites.create!(recipe: @recipe)
    
    redirect_to :back
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @recipe = @favorite.recipe
    @favorite.destroy
    redirect_to :back
  end
end