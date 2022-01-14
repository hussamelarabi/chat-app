class ChatsController < ApplicationController
  before_action :validate_params, only: [:get_chats, :create]

  def get_chats
    chats = Chat.where(app_token: @params['token']).order(id: :ASC).as_json(only: [:chat_number, :app_token, :created_at])
    if chats.nil?
      render json: { 'response': 'No chats found' }, status: :no_content
    else
      render json: { 'response': 'ok', 'chats': chats }, status: :ok
    end
  end

  def create
    app = Application.find_by_token(@params['token'])
    if app.nil?
      render json: { 'response': 'Application token does not exist' }, status: :no_content
    else

      ChatsWorker.perform_async(@params['token'])
      render json: { 'response': 'Chat creation request added' }, status: :accepted
    end
  end

  def search_chat
    @params = params

    chat = Chat.where(app_token: @params['token'], chat_number: @params['chat_number']).first
    if chat.nil?
      render json: { 'response': "Chat not found, check parameters" }, status: :no_content
    else
      messages = Message.search(@params['query']).as_json.map(&:values).select { |table, type, id, timestamp, message|
        message["chat_id"] == chat['id']
      }.map(&:last)

      if messages.empty?
        render json: { 'response': "No match found" }, status: :no_content
      else
        messages.each { |message|
          message.delete('id')
          message.delete('chat_id')
          message.delete('updated_at')
        }
        render json: { 'response': "ok", 'messages': messages }, status: :ok
      end
    end

  end

  private

  def validate_params
    @params = params.permit(:token)
    if @params == {}
      render json: 'Invalid parameters', status: :unprocessable_entity
    end
  end
end

