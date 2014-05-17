class PostsController < ApplicationController

	def index		
		# if params['q']
		# 	page = params[:page] || 1
		# 	@posts = Post.page(params[:page]).per(9)
		# else 
		# 	@posts = Post.page(params[:page]).per(9)
		# end
		if params[:q]
			p @posts = Post.where("title like '%#{params[:q]}%'")
		end
		if params[:category]
			p @posts = Post.all if @posts.blank?
			p @posts = @posts.where(:catagory_id =>params[:catagory])
		end
		if params[:q].blank? and params[:category].blank?
			p @posts = Post.all 
		end
		@posts = @posts.page(params[:page]).per(9)

		@catagories = Category.all
		respond_to do |format|
	      format.html
	      format.js
	    end

	end

	def home
	end

end
