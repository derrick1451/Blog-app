class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end
  def show
    @user_id = User.find(params[:id])
    render json: @user_id
  end
end
