class NotificationPresenter
  def initialize(current_user)
    @current_user = current_user
  end

  def list
    @mentions = []
    @likes = []
    @retweets = []

    @current_user.mentioned_in_tweets.order('created_at DESC').limit(20).each do |mention|
      seconds_ago = Time.now.ago(mention.created_at.to_i).to_i
      time_ago_string = get_time_string(seconds_ago)

      @mentions << [
        mention.user.id,
        mention.id,
        "mentioned you in a",
        time_ago_string,
        seconds_ago
      ]
    end

    @current_user.tweets_likes.order('created_at DESC').limit(20).each do |like|
      seconds_ago = Time.now.ago(like.created_at.to_i).to_i
      time_ago_string = get_time_string(seconds_ago)

      @likes << [
        like.user.id,
        like.tweet.id,
        "likes your",
        time_ago_string,
        seconds_ago
      ]
    end

    @current_user.retweets.order('created_at DESC').limit(20).each do |retweet|
      seconds_ago = Time.now.ago(retweet.created_at.to_i).to_i
      time_ago_string = get_time_string(seconds_ago)

      @retweets << [
        retweet.user.id,
        retweet.id,
        "retweeted your",
        time_ago_string,
        seconds_ago
      ]
    end

    notifications = @mentions + @likes + @retweets

    notifications.sort! { |x, y| x[4] <=> y[4] }
  end

  private

  def get_time_string(seconds_ago)
    time_ago = seconds_ago/(60)

    if (time_ago / (60 * 24) > 0)
      return ((time_ago / (60 *24)).to_s + "days ago")
    elsif (time_ago / 60 > 0)
      return ((time_ago / 60).to_s + "hours ago")
    else
      return (time_ago.to_s + " minutes ago")
    end
  end
end
