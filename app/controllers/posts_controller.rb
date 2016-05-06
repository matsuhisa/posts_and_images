class PostsController < ApplicationController
  permits :title, :description, images: [:file_name, :description, :extension, :file]

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

s3 = Aws::S3::Client.new
response = s3.list_buckets

        if file ||= image['file']
          # File.open('./tmp/'+ file.original_filename, 'wb') do |openfile|
          #   openfile.write(file.read)
          # end

s3.put_object(
    bucket: ENV['S3_BUCKET'],
    body: file.read,
    key: file.original_filename
)

          image['upload_file'] = file
          image['file_name'] = file.original_filename
          image['extension'] = File.extname(file.original_filename)
          images[index] = Image.new(image)
        end
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
