class PostsController < ApplicationController

	def index		
		# if params['q']
		# 	page = params[:page] || 1
		# 	@posts = Post.page(params[:page]).per(9)
		# else 
		# 	@posts = Post.page(params[:page]).per(9)
		# end
		unless params[:q].blank?
			@posts = Post.where("title like '%#{params[:q]}%'")
		end
		unless params[:category].blank?
			@posts = Post.all if @posts.blank?
			@posts = @posts.where(:category_id =>params[:category])
		end
		if params[:q].blank? and params[:category].blank?
			@posts = Post.all 
		end
		@posts = @posts.order("id desc").page(params[:page]).per(9)

		@catagories = Category.all
		respond_to do |format|
	    format.html
	    format.js
	  end

	end

	def home
	end

end
