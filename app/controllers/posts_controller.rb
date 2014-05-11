class PostsController < ApplicationController
	def index		
		@posts = Post.page(params[:page]).per(9)
	end
	def home

	end
end
