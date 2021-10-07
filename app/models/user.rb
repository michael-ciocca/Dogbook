class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dogs, inverse_of: :owner
  has_many :likes
  has_many :liked_dogs, through: :likes, source: :dog
end
