class MentionsCreator

  def initialize(tweet)
    @tweet = tweet
  end

  def call
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
  end

end
