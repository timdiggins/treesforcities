# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def editor?
    logged_in? && current_user.editor
  end
  
  def admin?
    logged_in? && current_user.admin
  end
end
