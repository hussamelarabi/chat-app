class MessagesController < ApplicationController
  before_action :validate_params, only: [:get_messages, :create]

  def get_messages
    chat = Chat.where(app_token: @params['token'], chat_number: @params['chat_number'])
    if chat.empty?
      render json: { 'response': "Chat not found" }, status: :no_content
    else
      chat_id = chat[0].as_json['id']
      messages = Message.where(chat_id: chat_id) #.as_json(only: [:message_number, :body, :created_at])
      if messages.empty?
        render json: { 'response': "No messages found" }, status: :no_content
      else
        render json: { 'response': 'ok', 'messages': messages.as_json(only: [:message_number, :body, :created_at]) }, status: :ok
      end
    end
  end

  def create
    chat = Chat.where(app_token: @params['token'], chat_number: @params['chat_number']).first
    if chat.nil?
      render json: { 'response': "Chat does not exist" }, status: :unprocessable_entity
    else

      MessagesWorker.perform_async(@params['token'], @params['chat_number'], @params['body'])
      render json: { 'response': 'Message creation request added' }, status: :accepted
    end
  end

  def update
    @params = params
    chat = Chat.where(app_token: @params['token'], chat_number: @params['chat_number']).first

    if chat.nil?
      render json:{'response': 'Chat number invalid'}, status: :unprocessable_entity
    else
      message = Message.where(message_number: @params['message_number'], chat_id: chat['id']).first
      if message.nil?
        render json:{'response': 'Message number invalid'}, status: :unprocessable_entity
      else
        if message.update(body: @params['body'])
          render json:{'response': 'Message edited'}, status: :ok
        else
          render json:{'response': 'Update Failed'}, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def validate_params
    @params = params.permit(:token, :chat_number, :body)
    if @params == {}
      render json: 'Invalid parameters', status: :unprocessable_entity
    end
  end

end
