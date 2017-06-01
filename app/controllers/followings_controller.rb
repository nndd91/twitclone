class FollowingsController < ApplicationController

  def create
    @following = Following.new(follower_id: params[:follower_id],
                               followed_id: params[:profile_id])
    if @following.save
      redirect_to profile_path(params[:profile_id])
    else
    end
  end

  def destroy
    Following.find(params[:following_id]).destroy
    redirect_to profile_path(params[:id])
  end

end
