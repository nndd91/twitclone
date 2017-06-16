class TweetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @tweets = Tweet.all.order('created_at DESC')
    @user = current_user
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
      check_tags
      redirect_to root_path
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

  def theme
    @user = current_user
    @user.theme = params[:theme]
    @user.save
    redirect_to root_path
  end

  def create_retweet

  end

  private
  def tweet_params
    params.require(:tweet).permit(:body, :user_id, :media_location, :retweet_id)
  end

  def check_tags
    pattern = /\A#\w+/
    tag_array = []
    @tweet.body.split(' ').map do |word|
      if pattern.match?(word)
        tag_array << word
      end
    end

    tag_array.each do |tag|
      tag.gsub!('#', '')
      if Tag.exists?(name: tag)
        @tweettag = @tweet.tagtweets.build(tag: Tag.find_by(name: tag))
        @tweettag.save
      else
        @tag=Tag.create(name:tag)
        @tweettag = @tweet.tagtweets.build(tag: Tag.find_by(name: tag))
        @tweettag.save
      end
    end
  end

end
