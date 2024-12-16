class CommentsController < ApplicationController
  before_action :set_capsule

  def index
    @comments = @capsule.comments.order(created_at: :desc)
    render json: @comments.map { |comment|
      {
        user_name: comment.user.name,
        content: comment.comment,
        created_at: comment.created_at.strftime('%Y-%m-%d %H:%M:%S')
      }
    }
  end

  def create
    @comment = @capsule.comments.create(comment_params.merge(user_id: current_user.id))

    if @comment.save
      render json: {
        id: @comment.id,
        content: @comment.comment,
        user_name: @comment.user.name,
        created_at: @comment.created_at.strftime('%d/%m/%Y %H:%M'),
      }, status: :created
    else
      render json: { error: "Unable to add comment" }, status: :unprocessable_entity
    end
  end

  private

  def set_capsule
    @capsule = Capsule.find(params[:capsule_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
