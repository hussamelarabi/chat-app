class MessagesWorker
  include Sidekiq::Worker

  sidekiq_options retry: true

  def perform(token, chat_number, body)
    Message.with_advisory_lock('operation-lock') do
      chat = Chat.where(app_token: token, chat_number: chat_number).first

      chat_id = chat.as_json['id']
      latest_message = Message.where(chat_id: chat_id).order(message_number: :DESC).first

      if latest_message.nil?
        message = Message.new(body: body, chat_id: chat_id, message_number: 1)
      else
        message = Message.new(body: body, chat_id: chat_id, message_number: latest_message['message_number'] + 1)
      end

      if message.save
        unless chat.update(messages_count: chat.as_json['messages_count'] + 1)
          message.destroy
        end

      end
    end
  end
end
