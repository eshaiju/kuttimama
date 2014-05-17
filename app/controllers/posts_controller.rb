class PostsController < ApplicationController

	def index		
		if params['q']
			page = params[:page] || 1
			# @posts = Sunspot.search(Post) do	
			#   fulltext params['q']
			#   with :category_id, params['category'] unless params['category'].nil?
			#   paginate :page => page, :per_page => 9			  
			# end.results
			@posts = Post.page(params[:page]).per(9)
		else
			@posts = Post.page(params[:page]).per(9)
		end
		respond_to do |format|
	      format.html
	      format.js
	    end
	end

	def home
	end

end
