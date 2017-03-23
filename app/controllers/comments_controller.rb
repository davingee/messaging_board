class CommentsController < ApplicationController

  before_action :find_post, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  authorize_resource

  def create
    @comment = @post.comments.new( comment_params.merge( user_id: current_user.id ) )
    respond_to do |format|
      if @comment.save
        format.html { redirect_to "#{ post_path(@post) }##{@comment.id}" }
      else
        flash['error'] = @comment.errors.messages.map{ |k, v| "#{ @comment.class.name } #{ k } #{ v[0] }"  }.join(", ")
        format.html { redirect_to @post }
      end
    end
  end

  def edit

  end

  def update
    if @comment.update( comment_params )
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_post
      @post = Post.find( params[:post_id] )
    end

    def find_comment
      @comment = @post.comments.find( params[:id] )
    end

end
