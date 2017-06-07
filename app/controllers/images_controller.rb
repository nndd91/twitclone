class FollowingsController < ApplicationController

  def create
    Following.create(follower_id: params[:follower_id],
                     followed_id: params[:profile_id])
    redirect_to profile_path(params[:profile_id])
  end

  def destroy
    @image = Image.find(params[:id])
    @image.remove_media_location!
    @image.saves
    @image.destroy
    respond_to do |format|
      format.js
    end
  end

end
