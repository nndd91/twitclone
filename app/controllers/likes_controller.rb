class LikesController < ApplicationController

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.likes.build(user_id: current_user.id)
    redirect_to tweet_path(@tweet)
  end

  def destroy
    byebug
    Like.find(params[:id]).destroy
    redirect_to tweet_path(params[:tweet])
  end

end
