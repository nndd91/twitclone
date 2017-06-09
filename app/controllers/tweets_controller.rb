class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      @image = @tweet.images.build(media_location: tweet_params[:media_location])
      @image.save
      redirect_to edit_tweet_path(@tweet)
    else
      render :new
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params)
    @image = @tweet.images.build(media_location: tweet_params[:media_location])
    @image.save
    redirect_to edit_tweet_path(@tweet)
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def feed
    @user = current_user
    @following = current_user.following_ids
    @tweets = Tweet.get_tweets(@following, current_user.id)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :user_id, :media_location)
  end
end
