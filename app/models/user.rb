class User < ApplicationRecord
  has_many :vehicles, dependent: :destroy
  has_many :favorites, dependent: :destroy 

  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 8, message: "Minimum 8 characters required" }
  
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
