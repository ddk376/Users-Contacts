# require 'json'

class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def show
    render json: User.find( params[:id] )
  end

  def create
    user = User.new(user_params)
    if user.save  # returns false if it doesn't save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity  # name of error message 422
      )
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: updated_user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    destroyed_user = User.destroy(params[:id])
    render json: destroyed_user
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

end
