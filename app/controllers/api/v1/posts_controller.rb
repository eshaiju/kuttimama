class Api::V1::PostsController < Api::ApiController
	def index
    @posts = Post.all
    if @posts.present?
      render :status => :ok, :json =>  @posts
    else
      render :status => :not_found, :json => {:message => 'Posts not found'}
    end
  end

end