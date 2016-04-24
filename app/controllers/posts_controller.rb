class PostsController < ApplicationController
  permits :title, :description

  def index
    @posts = Post.all
  end

  def show(id)
    @post = Post.find(id)
  end

  def new
    @post = Post.new
  end

  def confirm(post)
    @post = Post.new(post)
    unless @post.valid?
      render(:new)
    end
  end

  def create(post)
    @post = Post.new(post)
    if @post.save
      redirect_to(complete_posts_url)
    else
      render(:new)
    end
  end

  def complete
  end

  def edit
  end

  def update(post)
  end

  def destroy
  end

end
