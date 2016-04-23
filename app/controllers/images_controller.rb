class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  permits :file_name, :extension, :description

  # GET /images
  def index
    @images = Image.all
  end

  # GET /images/1
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  def create(image)
    @image = Image.new(image)

    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  # PUT /images/1
  def update(image)
    if @image.update(image)
      redirect_to @image, notice: 'Image was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy

    redirect_to images_url, notice: 'Image was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image(id)
      @image = Image.find(id)
    end
end
