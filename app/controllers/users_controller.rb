# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, except: %i[index new create]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Register success'
      redirect_to @user
    else
      flash.now[:danger] = 'Register error'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmination)
  end

  def find_user
    (@user = User.find_by(id: params[:id])) || not_found
  end
end
