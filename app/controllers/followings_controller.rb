class FollowingsController < ApplicationController

  def create
    Following.create(follower_id: params[:follower_id],
                     followed_id: params[:profile_id])
    redirect_to profile_path(params[:profile_id])
  end

  def destroy
    Following.find(params[:following_id]).destroy
    redirect_to profile_path(params[:id])
  end

end
