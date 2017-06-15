class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @tweets = Tweet.all.order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      if tweet_params[:media_location].present?
        @image = @tweet.images.build(media_location: tweet_params[:media_location])
        @image.save
      end
      MentionsCreator.new(@tweet).call
      redirect_to tweets_path
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
    MentionsUpdater.new(@tweet).call
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

  def retweet
    @tweet = Tweet.new
    respond_to do |format|
      format.js
    end
  end

  def create_retweet

  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :user_id, :media_location, :retweet_id)
  end
end
