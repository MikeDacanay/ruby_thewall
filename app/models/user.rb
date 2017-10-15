class User < ActiveRecord::Base
	validates :user_name, presence: true, length: { minimum: 5 }, uniqueness: { case_sensitive: false}  
	has_many :messages
	has_many :comments
end
