class CommentsController < ApplicationController
  def create
    @comment = Comment.create(params[:comment])

    respond_to do |format|
      format.html { redirect_to (@comment.movie || root_url), notice: 'Comment was successfully created.' }
      format.json { render json: @comment, status: :created, location: @comment }
    end
  end
end
