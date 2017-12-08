class PropertyImagesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_property
  before_action :set_property_image, only: :destroy

  def new
    @property_image = PropertyImage.new
  end

  def create
    @property_image = @property.property_images.create(image_params)
  end

  def destroy
    @property_image_id = @property_image.id
    @property_image.destroy
  end

  private

  def set_property_image
    @property_image = PropertyImage.find(params[:id])
  end

  def set_property
    @property = Property.find(params[:property_id])
  end

  def image_params
    params.require(:property_image).permit(:image, :property_id)
  end
end
