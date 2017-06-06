class MessageController < ApplicationController

	def create
    @profile_id=params[:profile_id]
    @message = Message.create(from_user_id: params[:profile_id],
    to_user_id: params[:message][:to_user_id], body: params[:message][:body])

    if @message.save
      redirect_to profile_message_index_path
    else
      render :new
    end

  end

  def new
    @profile_id=params[:profile_id]
    @user=User.all
    @message = Message.new
  end

  def show
   @message = Message.find(params[:id])
  end

  def index
    @message = Message.where(from_user_id:params[:profile_id])
    #@user= User.find(params[:to_user_id])
 
   end

  def destroy
   Message.find(params[:id]).destroy
   redirect_to profile_message_path(params[:profile_id])
  end

  private
  def message_params
    params.require(:body).permit(:body, :from_user_id, :to_user_id)
  end

end