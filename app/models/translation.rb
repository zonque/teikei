class Translation < ActiveRecord::Base
  belongs_to :translatable, :polymorphic => true
  attr_accessible :locale, :title

  validates :translatable, presence: true
  validates :locale, presence: true, length: { maximum: 10 }
  validates :title, presence: true
end
