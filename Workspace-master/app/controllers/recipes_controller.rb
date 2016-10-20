class RecipesController < ApplicationController

  before_action :set_recipe, only: [:edit, :update, :show, :like, :destroy]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def show
     @comments = Comment.where(recipe_id: @recipe.id).order("created_at DESC")

    if @comments.blank?
      @avg_rating = 0
    else
      @avg_rating = @comments.average(:rating)
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save
      flash[:success] = "Recipe was created successfully!"
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was successfully updated!"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
  end

  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your Selection was successful"
      redirect_to :back
    else
      flash[:error]  = "You can like/dislike a recipe once!"
      redirect_to :back
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    if current_user != @recipe.chef
      flash[:danger] = "You can only edit your own recipes"
      redirect_to recipes_path
    end
  end

  def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end

end
