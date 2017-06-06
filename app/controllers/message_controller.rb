class MessageController < ApplicationController

	def create
    Message.create(from_user_id: params[:from_user_id],
      to_user_id: params[:to_user_id], body: params[:body])
    redirect_to message_path(params[:from_user_id])
  end

  def show
   @message = Message.find(params[:id])
 end

 def index
  @message=Message.where(from_user_id:params[:from_user_id])

 end

 def destroy
   Message.find(params[:id]).destroy
   redirect_to message_path(params[:from_user_id])
 end

end