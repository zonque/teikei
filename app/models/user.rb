class User < ActiveRecord::Base
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  has_paper_trail

  has_many :places

  validates :name, presence: true, length: { within: 2..60 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    email: true, length: { maximum: 100 }

  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 },
                       on: :create
  validates :password, confirmation: true,
                       length: { within: 6..40},
                       allow_blank: true,
                       on: :update

  validates :password_confirmation, presence: true, on: :create
  validates_associated :places

  after_create :add_default_role

  def add_default_role
    add_role :user
  end
end
