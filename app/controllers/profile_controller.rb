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
  
  def search
    @allusers = User.new
    if params[:user] == nil or params == nil
      @user = User.all
    else
      @user = User.where(["first_name LIKE ?", "%#{params[:user][:first_name]}%"])
    end
  end

  private

  def find_following
    Following.find_by(follower_id: current_user.id,
                      followed_id: @user.id)
  end

end
