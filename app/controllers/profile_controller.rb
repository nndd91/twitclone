class ProfileController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:user_id])
    @tweets = Tweet.where(user_id: @user.id)
  end

  def following
    @user = User.find(params[:user_id])
    @relationship = @user.following
    
  end

  def followers
    @user = User.find(params[:user_id])
    @relationship = @user.followers
  end

  def follow
    @user = User.find(params[:user_id])
    @user.follow_user(current_user.id, @user.id)
    redirect_to profile_show_path(@user.id)
  end

end