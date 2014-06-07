class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'meta_tags'

  def metatags
    @page_title      ||= "Kuttimama || Malayalam movie fb comments"
    @page_description ||= "malayalam movie dialogues,malayalam movie comments,malayalam movie comments for facebook,malayalam movie comments scrap,funny malayalam movie comments,facebook funny malayalam movie comments,fb funny malayalam movie comments, malayalm  funny facebook, malayalm  funny facebook images, new malayalam films, malayalam films, comedy dialogues, mohanlal innocent jagathy sreenivasan fahad fazil,evergreen malayalam film dialogues, top 10 malayalam dialogues,malayalam funny dialogues, post facebook photo comment, malayalam funny pictures, Latest Malayalam Photo Comments,Latest Malayalam Funny Film Dialogues New Collection,Facebook photo commenting pictures, fb malayalam photo comments, film dialogues, new movie dialogues, latest dileep dialogues,kuttimama,kuttymama,mohenlal,mammooty"
    @page_keywords    ||= "malayalam movie dialogues,malayalam movie comments,malayalam movie comments for facebook,malayalam movie comments scrap,funny malayalam movie comments,facebook funny malayalam movie comments,fb funny malayalam movie comments, malayalm  funny facebook, malayalm  funny facebook images, new malayalam films, malayalam films, comedy dialogues, mohanlal innocent jagathy sreenivasan fahad fazil,evergreen malayalam film dialogues, top 10 malayalam dialogues,malayalam funny dialogues, post facebook photo comment, malayalam funny pictures, Latest Malayalam Photo Comments,Latest Malayalam Funny Film Dialogues New Collection,Facebook photo commenting pictures, fb malayalam photo comments, film dialogues, new movie dialogues, latest dileep dialogues,kuttimama,kuttymama,mohenlal,mammooty"
  end
end
