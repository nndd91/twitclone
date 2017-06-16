class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @tweets =  @tag.tweets
  end

  def index
  end
end
