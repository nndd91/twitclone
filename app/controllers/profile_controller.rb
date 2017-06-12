class ProfileController < ApplicationController

  before_action :get_user, only: [:show, :get_following, :get_followers]
  before_action :check_private, only: [:show]

  def show
    @tweets = Tweet.where(user_id: @user.id)
    @following = find_following
  end

  def get_following
    @relationship = @user.following
    @following = find_following
  end

  def get_followers

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

  def get_user
    @user = User.find(params[:id])
  end

  def check_private
    if @user.private
      if !@user.followers.exists?(current_user.id)
        flash[:notice] = "This profile is private!"
        redirect_to root_path
      end
    end
  end
end
