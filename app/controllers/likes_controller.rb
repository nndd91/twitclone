class LikesController < ApplicationController

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.build(user_id: current_user.id)
    respond_to do |format|
      if @like.save
        format.html { redirect_to tweets_path }
        format.js
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @tweetid = @like.tweet_id
    @tweet = Tweet.find(@tweetid)
    @like.destroy
    respond_to do |format|
      format.html {
        redirect_to tweets_path
      }
      format.js
    end
  end

end
