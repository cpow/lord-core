class PropertyImagesController < ApplicationController
  def new(*args)
    @property_image = PropertyImage.new
  end

  def create(*args)
    @property_image = PropertyImage.create(image_params)
  end

  private

  def image_params
    params.require(:property_image).permit(:image)
  end
end
