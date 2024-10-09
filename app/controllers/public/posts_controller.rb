class Public::PostsController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to mypage_path(@post)  
    else
      @posts = Post.all
      render :new 
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments  
    @user = @post.user
    @user = current_user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to mypage_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'Post not found.'
    end
  end
  
  def search
   @section_title = "「#{params[:search]}」の検索結果"
   @posts = if params[:search].present?
               Post.where(['title LIKE ? OR body LIKE ?',
                        "%#{params[:search]}%", "%#{params[:search]}%"])
           else
             Post.none
           end
  end
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image).merge(user_id: current_user.id)
  end
  
  def is_matching_login_user
    post =Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end
end