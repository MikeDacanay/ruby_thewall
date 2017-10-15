class Message < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :message, length: { minimum: 5 }
  validates :user_id, presence: true
end
