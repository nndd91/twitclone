class MessageController < ApplicationController

	def create
		Following.create(from_user_id: params[:from_user_id], 
			to_user_id: params[:to_user_id],
			message: params[:message])

    redirect_to message_path(params[:profile_id])
  end

  def index
  	    @message = Message.find(params[:from_user_id])
  end

  def destroy
  	Following.find(params[:id]).destroy
  	redirect_to message_path(params[:id])
  end

end