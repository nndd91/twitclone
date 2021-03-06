class MessageController < ApplicationController

	def create
    @message = Message.create(message_params)

    if @message.save
      redirect_to message_index_path
    else
      render :new
    end
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.js
    end
  end


  def close
    respond_to do |format|
      format.js
    end
  end

  def index
    @inbox = Message.where(to_user_id: current_user.id)
    @outbox = Message.where(from_user_id: current_user.id)
    @user = current_user
   end

  def destroy
   @message=Message.find(params[:id]).destroy
   redirect_to message_index_path
  end

  private

  def message_params
    params.require(:message).permit(:body, :from_user_id, :to_user_id)
  end

end
