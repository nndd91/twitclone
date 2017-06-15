module ApplicationHelper
  def current_theme
    current_user.theme || 'default'
  end
end
