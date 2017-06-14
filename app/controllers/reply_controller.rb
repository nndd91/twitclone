class ReplyController < ApplicationController

  def create
    @tweet = Tweet.find(params[:id])

    @message = @tweet.replys.build(message_params)
    @message.user = current_user
    if @message.save
      redirect_to tweets_path
    else
      render :new
    end

  end

  def new
    @reply = Reply.new
    @tweet= Tweet.find(params[:id])
  end

  #def show
   #@message = Message.find(params[:id])
  #end

  def index
    @reply = Reply.where(tweet_id: params[:id])
  end

  def message_params
    params.require(:reply).permit(:body)
    
  end

end
