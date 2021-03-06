class PostsController < ApplicationController
 before_action :authenticate_user!
before_action :set_user, except: [:like]
before_action :set_post, only: [:show, :edit, :update, :destroy, :like]

 def index
  @posts = Post.all.order(created_at: :desc)
 end

 def new
 end

 def edit
 end

 def create
  if params[:content].present?
   @post = Post.new(content: params[:content], user_id: @user.id)
   @post.save
   respond_to do |format|
    format.js
   end
  end
 end

 def update
  if params[:content].present?
   @post.update content: params[:content]
  end
 end

 def show
 end

 def destroy
  @post.destroy
  redirect_to root_path(current_user.id)
 end

 def like
  if params[:id].present?
   @like = Like.like_post(current_user, @post)
  end
 end

 private

 def set_user
  @user = User.find_by(id: params[:user_id])
  redirect_to page_not_found unless @user.present?
 end

 def set_post
  @post = Post.find_by(id: params[:id])
  redirect_to page_not_found unless @post.present?
 end
end
