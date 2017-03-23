class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(
    :database_authenticatable, 
    :registerable,
    :recoverable, 
    :rememberable, 
    :trackable, 
    :validatable,
  )

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def name
    "#{ first_name.capitalize } #{ last_name.capitalize }"
  end

end
