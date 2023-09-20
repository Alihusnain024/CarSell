class User < ApplicationRecord
  has_many :vehicles
  has_many :favorites

  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
  validates_format_of :username, with: /\A[\w\-]+\z/, message: "can only contain letters, numbers, underscores, and dashes"
  validates :password, presence: true, length: { minimum: 8 }
  validate :password_complexity

  def password_complexity
    return unless password.present?

    unless password.match(/^(?=.*[A-Z])(?=.*[!@#$%^&*()_+])[a-zA-Z0-9!@#$%^&*()_+]+$/)
      errors.add :password, "must contain at least one uppercase letter and one special character"
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
