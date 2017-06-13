class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!

  before_action :get_notifications, except: []

  def get_notifications
    if !current_user.nil?
      @mentions = []
      @likes = []

      current_user.mentions.order('created_at DESC').limit(20).each do |mention|
        days_ago = Time.now.ago(mention.created_at.to_i).to_i/(60*60*24)
        @mentions << [ mention.user.id, mention.tweet.id, "mentions you in a", days_ago ]
      end

      current_user.likes.order('created_at DESC').limit(20).each do |like|
        days_ago = Time.now.ago(like.created_at.to_i).to_i/(60*60*24)
        @likes << [ like.user.id, like.tweet.id, "likes your", days_ago ]
      end

      @notifications = @mentions + @likes

      @notifications.sort! { |x, y| x[3] <=> y[3] }
    end
  end
end
