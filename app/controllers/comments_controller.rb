class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)

    respond_to do |format|
      format.html do
        redirect_to @comment.movie || root_url,
                    notice: 'Comment was successfully created.'
      end
      format.json do
        render json: @comment,
               status: :created,
               location: @comment
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:name, :body, :movie_id)
  end
end
