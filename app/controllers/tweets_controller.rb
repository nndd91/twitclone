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
      if tweet_params[:media_location].present?
        @image = @tweet.images.build(media_location: tweet_params[:media_location])
        @image.save
      end
      pattern = /\A@\w+/
      mention_array = []
      @tweet.body.split(' ').map do |word|
        if pattern.match?(word)
          mention_array << word
        end
      end

      mention_array.each do |mention|
        mention.gsub!('@', '')
        if User.exists?(username: mention)
          @mention = @tweet.mentions.build(user: User.find_by(username: mention))
          if !Mention.exists?(tweet: @tweet, user: User.find_by(username: mention))
            @mention.save
          end
        end
      end

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

    # Check for mentions
    pattern = /\A@\w+/
    mention_array = []
    @tweet.body.split(' ').map do |word|
      if pattern.match?(word)
        mention_array << word
      end
    end

    mention_array.each do |mention|
      mention.gsub!('@', '')
      if User.exists?(username: mention)
        @mention = @tweet.mentions.build(user: User.find_by(username: mention))
        if !Mention.exists?(tweet: @tweet, user: User.find_by(username: mention))
          @mention.save
        end
      end
    end

    #Delete removed mentions
    mention_existed_array = []
    @tweet.mentions.each do |mention|
      mention_existed_array << mention.user.username
    end

    delete_array = mention_existed_array.reject { |mention| mention_array.include?(mention) }

    delete_array.each do |mention|
      @mention = Mention.find_by(user: User.find_by(username: mention))
      @mention.destroy
    end

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
