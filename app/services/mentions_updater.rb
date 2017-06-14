class MentionsUpdater

  def initialize(tweet)
    @tweet = tweet
  end

  def call
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
  end

end
