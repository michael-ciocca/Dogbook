class Dog < ApplicationRecord
  has_many_attached :images

  # optional: true prevents problems with dogs created before this association exsits
  # you probably wouldn't want this optional in a new application
  belongs_to :owner, class_name: "User", foreign_key: "user_id", inverse_of: :dogs, optional: true
  has_many :likes
  has_many :admirers, through: :likes, source: :user

  scope :order_by_likes_in_past_hour, -> {
    joins(:likes).
    group(:id).
    order(Arel.sql("count(likes.id) DESC")).
    where("likes.created_at BETWEEN ? AND ?", (Time.current - 1.hour), Time.current)
  }
end
