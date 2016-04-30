class PostsController < ApplicationController
  permits :title, :description, images: [:file_name, :description]

  def index
    @posts = Post.all
  end

  def show(id)
    @post = Post.find(id)
  end

  def new
    @post = Post.new
    2.times {
      @post.images.build
    }
  end

  def confirm(post)
    images = []
    if post['images'].to_a.any?
      post['images'].each_with_index do |image, index|
        images[index] = Image.new(image)
      end
      post['images'] = images
    end

    if images.any?
      @post = Post.new(post)
    else
      @post = Post.new(post)
    end

    unless @post.valid?
      render(:new)
    end
  end

  def create(post)
		images = []
    if post['images'].to_a.any?
      post['images'].each_with_index do |image, index|
        images[index] = Image.new(image)
      end
      post['images'] = images
    end

    if images.any?
      @post = Post.new(post)
    else
      @post = Post.new(post)
    end

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
