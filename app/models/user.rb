class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :providers, dependent: :destroy
  has_many :conversations
  has_one :client, dependent: :destroy
  validates :role, presence: true

  enum role: {
    client: 0,
    provider: 1
  }
end
