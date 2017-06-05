class MessageController < ApplicationController

	def create
    redirect_to message_path(params[:profile_id])
  end

  def index
   @message = Message.find(params[:from_user_id])
 end

 def destroy
   Message.find(params[:id]).destroy
   redirect_to message_path(params[:id])
 end

end