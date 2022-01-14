class Chat < ApplicationRecord
  belongs_to :application, foreign_key: :app_token
  has_many :messages, dependent: :destroy


end
