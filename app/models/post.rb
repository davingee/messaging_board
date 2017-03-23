class Post < ActiveRecord::Base

  belongs_to :author, class_name: 'User', foreign_key: :user_id, validate: true

  has_many :comments, -> { order('created_at desc') }, dependent: :destroy

  scope :newest_first, -> { order('created_at desc') }

  validates :title, :user_id, :body, presence: true

end
