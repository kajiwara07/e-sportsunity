class Public::CommentsController < ApplicationController
    
    def create
        @post = Post.find(params[:post_id]) # インスタンス変数として設定
        @comment = current_user.comments.new(comment_params)
        @comment.post_id = @post.id
        if @comment.save
            redirect_to post_path(@post)
        else
            @comments = @post.comments.includes(:user) # コメント一覧を再取得
            render 'public/posts/show'
        end 
    end

    def destroy
        comment = current_user.comments.find_by(id: params[:id], post_id: params[:post_id])
        if comment
            comment.destroy
            flash[:alert] = 'コメントを削除しました'
        else
            flash[:alert] = 'コメントが見つかりませんでした'
        end
        redirect_to post_path(params[:post_id])
    end
    
    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
