class Api::V1::PostsController < Api::ApiController
  def index
    if params[:q].present?
      @posts = Post.where("title like '%#{params[:q]}%'")
    else
      @posts = Post.all
    end
    if @posts.present?
      render :status => :ok, :json =>  @posts
    else
      render :status => :not_found, :json => {:message => 'Posts not found'}
    end
  end
end
