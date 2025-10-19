class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    load_and_authorize_resource

    def index
        @recipes = Recipe.all
    end

    def show
    end

    def new
        @recipe = current_user.recipes.build
    end

    def create
        @recipe = current_user.recipes.build recipe_params
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            redirect_to new_recipe_path, alert: @recipe.errors.full_messages.to_sentence
        end
    end

    def edit
    end

    def update
        if @recipe.update recipe_params
            redirect_to recipe_path(@recipe), notice: "Receta actualizada exitosamente"
        else
            redirect_to edit_recipe_path(@recipe), alert: @recipe.errors.full_messages.to_sentence
        end
    end

    def destroy
        @recipe.destroy
        redirect_to recipes_path
    end

    private
    def recipe_params
        params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
    end

    def set_recipe
        @recipe = Recipe.find params[:id]
    end
end
