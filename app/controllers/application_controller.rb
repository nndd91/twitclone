class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :authenticate_user!

  before_action :get_notifications, except: []

  def get_notifications
    if !current_user.nil?
      @notifications = NotificationPopulator.new(current_user).calculate
    end
  end
end
