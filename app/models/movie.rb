class Movie < ActiveRecord::Base
  validates :title, presence: true
  scope :user_search, ->(user) { where(user_id: user.id) }
end
