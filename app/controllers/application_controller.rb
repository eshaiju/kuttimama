class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'meta_tags'

  def metatags
    @page_title      ||= "Kuttimama || Malayalam movie fb comments"
    @page_description ||= "latest malayalam movie comments for facebook"
    @page_keywords    ||= "malayalam fb comments,malayalam movie dialogues,malayalam movie comments,facebook funny malayalam movie comments,fb funny malayalam comments,comedy dialogues,fb malayalam photo comments,kuttimama,kuttymama"
  end
end
