# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def user_logged_in?
    session[:user_id]
  end
  
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
end
