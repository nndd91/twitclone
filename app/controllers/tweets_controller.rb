class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :user_id)
  end


end
