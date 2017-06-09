class ImagesController < ApplicationController

  def create
    # Not implemented yet.
  end

  def destroy
    @image = Image.find(params[:id])
    @tweet = Tweet.find(@image.tweet_id)
    @image.remove_media_location!
    @image.save
    @image.destroy
    respond_to do |format|
      format.js
    end
  end

end
