class CommentsController < ApplicationController
  before_action :set_bubble

  def create
    @comment = @bubble.comments.create(comment_params)
    @comment.save

    redirect_to bubble_path(@bubble, anchor: "comment_#{@comment.id}")
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_bubble
      @bubble = Bubble.find(params[:bubble_id])
    end
end
