class ProfileController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user.id)
    @following = find_following
  end

  def get_following
    @user = User.find(params[:id])
    @relationship = @user.following
    @following = find_following
  end

  def get_followers
    @user = User.find(params[:id])
    @relationship = @user.followers
    @following = find_following
  end


  private

  def find_following
    Following.find_by(follower_id: current_user.id,
                      followed_id: @user.id)
  end

end