class Comment < ActiveRecord::Base

  belongs_to :author, class_name: 'User', foreign_key: :user_id, validate: true

  belongs_to :post, validate: true

  validates :body, presence: true

end
