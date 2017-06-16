class TagsController < ApplicationController
 def show
   @tweet =  Tagtweet.find_by(tag_id:(params[:id]))
   #Tagtweet.find_by(tag:Tag.find_by((params[:id])))
 end

 def index
 end
end
