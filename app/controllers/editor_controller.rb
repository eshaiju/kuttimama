class EditorController < ApplicationController
   before_filter :metatags
  def new		
  	@catagories = Category.all
  end

  def create
  end

end
