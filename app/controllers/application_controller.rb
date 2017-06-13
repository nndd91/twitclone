class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!

  before_action :get_notifications, except: []

  def get_notifications
    if !current_user.nil?
      @mentions = []
      @likes = []

      current_user.mentions.order('created_at DESC').limit(20).each do |mention|
        seconds_ago = Time.now.ago(mention.created_at.to_i).to_i
        time_ago = seconds_ago/(60)
        if time_ago / 60 > 0
          time_ago /= 60
          if time_ago / 24 > 0
            time_ago /= 24
            time_ago_string = time_ago.to_s + "days ago"
          else
            time_ago_string = time_ago.to_s + "hours ago"
          end
        else
          time_ago_string = time_ago.to_s + " minutes ago"
        end

        @mentions << [ mention.user.id, mention.tweet.id, "mentions you in a", time_ago_string, seconds_ago ]
      end

      current_user.likes.order('created_at DESC').limit(20).each do |like|
        seconds_ago = Time.now.ago(like.created_at.to_i).to_i
        time_ago = seconds_ago/(60)
        if time_ago / 60 > 0
          time_ago /= 60
          if time_ago / 24 > 0
            time_ago /= 24
            time_ago_string = time_ago.to_s + "days ago"
          else
            time_ago_string = time_ago.to_s + "hours ago"
          end
        else
          time_ago_string = time_ago.to_s + " minutes ago"
        end

        @likes << [ like.user.id, like.tweet.id, "likes your", time_ago_string, seconds_ago ]
      end

      @notifications = @mentions + @likes

      @notifications.sort! { |x, y| x[4] <=> y[4] }
    end
  end
end
