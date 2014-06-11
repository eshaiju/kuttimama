class PostsController < ApplicationController
   before_filter :metatags
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
    unless params[:tag_id].blank?
      @posts = Post.all if @posts.blank?
      tag = Tag.find_by_id(params[:tag_id])
      @posts = tag.posts
      # @posts = @posts.where(:category_id =>params[:category])
    end
    unless params[:movie_id].blank?
      @posts = Post.all if @posts.blank?
      @posts = @posts.where(:movie_id =>params[:movie_id])
    end
    if params[:q].blank? and params[:category].blank? and params[:tag_id].blank? and  params[:movie_id].blank?
      @posts = Post.all 
    end
    @posts = @posts.order("id desc").page(params[:page]).per(9)

    @catagories = Category.all
    respond_to do |format|
      format.html
      format.js
    end

  end

  def show
    @post = Post.where("id =? or title=?",params[:id],params[:id]).first
    @catagories = Category.all
    @tags = @post.tags
    @post.category_id
    @related_posts = Post.where("category_id = ?  and id != ? or movie_id = ?  and id != ?", @post.category_id,@post.id, @post.movie_id,@post.id ).sample(5)
  end

  def home
  end

  def title_list
    list = Post.all.collect {|post| {:id => post.title,:name => "#{post.title}" }}
    # Tag.all.collect{|tag| list << {:id => tag.title,:name => "#{tag.title}"}}
    render :json => list
  end

  def tag_list
    list = Tag.all.collect{|tag| "#{tag.title}"}
    render :json => list
  end

  def movie_list
    list = Movie.all.collect{|movie| "#{movie.title}"}
    render :json => list
  end

end
