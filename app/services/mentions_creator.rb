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

      user = User.where("username ~* '#{mention}'").first

      if !@tweet.mentions.exists?(user: user)
        @mention = @tweet.mentions.build(user: user)
        @mention.save
      end
    end
  end

end
