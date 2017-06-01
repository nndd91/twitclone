class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      byebug
      redirect_to tweets_path
    else
      byebug
      render :new
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params)
    redirect_to tweets_path
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
    params.require(:tweet).permit(:body, :user_id)
  end


end
