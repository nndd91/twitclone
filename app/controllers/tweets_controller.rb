class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
  end

  def destroy
    @tweet.destroy
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :user_id)
  end


end
