# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_article, only: [:index, :create]

  def index
    @comments = @article.comments
    render json: { comments: @comments }
  end

  def show
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
