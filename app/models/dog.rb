class Dog < ApplicationRecord
  has_many_attached :images

  # optional: true prevents problems with dogs created before this association exsits
  # you probably wouldn't want this optional in a new application
  belongs_to :owner, class_name: "User", foreign_key: "user_id", inverse_of: :dogs, optional: true
  has_many :likes
  has_many :admirers, through: :likes, source: :user
end
