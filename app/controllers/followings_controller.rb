class FollowingsController < ApplicationController

  def create
  end

  def destroy
    Following.find(params[:id]).destroy
    redirect_to profile_show_path(@user.id)
  end

end