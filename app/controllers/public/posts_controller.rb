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
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments  
    @user = @post.user 
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
     @post = Post.find(params[:id])
   if @post.destroy
      flash[:notice] = '投稿は正常に削除されました。'
      redirect_to mypage_path
   else
      flash[:alert] = '投稿が見つかりません。'
      redirect_to posts_path
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
