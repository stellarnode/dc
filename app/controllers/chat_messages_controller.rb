class ChatMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index]

  def index
    @chat_messages = ChatMessage.all.order("created_at ASC")
    @chat_message = ChatMessage.new
    respond_to do |format|
      format.html
      format.json { render json: @chat_messages }
    end
  end

  def create
    @chat_message = current_user.chat_messages.build(chat_message_params)
    if @chat_message.save
      # ActionCable.server.broadcast 'chat',
      #   message: @chat_message.message,
      #   user: @chat_message.user.email
      # head :ok
      ChatChannel.broadcast_to(
        'chat',
        user: @chat_message.user.email,
        message: @chat_message.message
      )

    end

  end

  def update
  end

  def destroy
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:message)
  end

  def set_user
    cookies[:user_email] = current_user.email || 'guest'
  end

end
