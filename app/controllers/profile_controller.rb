class ProfileController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @tweets = Tweet.where(user_id: @user.id)
    @following = find_following
  end

  def get_following
    @user = User.find(params[:id])
    @relationship = @user.following
    
  end

  def get_followers
    @user = User.find(params[:id])
    @relationship = @user.followers
  end

  def follow
    @user = User.find(params[:user_id])
    Following.create(follower_id: current_user.id, followed_id: @user.id)
    redirect_to profile_show_path(@user.id)
  end

  def unfollow
    @user = User.find(params[:user_id])
    Following.find(params[:id]).destroy
    redirect_to profile_show_path(@user.id)
  end

  def feed
    @user = current_user
    @following = current_user.following_ids
    @tweets = Tweet.get_tweets(@following, current_user.id)
  end

  private

  def find_following
    Following.find_by(follower_id: current_user.id, followed_id: @user.id)
  end

end