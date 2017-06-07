class ImagesController < ApplicationController

  def create
  end

  def destroy
    @image = Image.find(params[:id])
    @image.remove_media_location!
    @image.save
    @image.destroy
    respond_to do |format|
      format.js
    end
  end

end
