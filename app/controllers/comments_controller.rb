class CommentsController < ApplicationController
  before_action :require_user
  before_action :find_comment, only: [:edit, :update]
  before_action :load_commentable
  before_action -> { correct_user(@comment) }, only: [:edit, :update]

  def create
    @comment = @commentable.comments.new(comment_params.merge!(user: current_user))

    if @comment.save
      flash[:success] = "Your comment has been posted."
      redirect_to @commentable
    else
      render @comment.commentable_type.downcase + "s/show"
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "Your comment has been updated."
      redirect_to @commentable
    else
      render :edit
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def load_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    def find_comment
      @comment = current_user.comments.find_by(id: params[:id])
    end
end
