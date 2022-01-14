class ChatsWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(app_token)
    Chat.with_advisory_lock('operation-lock') do
      app = Application.find_by_token(app_token)
      latest_chat = Chat.where(app_token: app_token).order(chat_number: :DESC).first
      if latest_chat.nil?
        new_chat = Chat.new(app_token: app_token, chat_number: 1)
      else
        new_chat = Chat.new(app_token: app_token, chat_number: latest_chat['chat_number'] + 1)
      end
      if new_chat.save
        unless app.update(chats_count: app['chats_count'] + 1)
          new_chat.destroy
        end
      end
    end
  end
end
