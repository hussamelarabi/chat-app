class Message < ApplicationRecord
  belongs_to :chat

  include Searchable
  settings do
    mappings dynamic: false do
      indexes :body, type: :text, analyzer: :english
    end
  end
end
