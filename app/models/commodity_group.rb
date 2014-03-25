class CommodityGroup < ActiveRecord::Base
  include Translatable

  has_many :commodities, :dependent => :destroy, :dependent => :destroy
  has_many :translations, :as => :translatable, :dependent => :destroy

  attr_accessible :name, :priority, :translations_attributes
  accepts_nested_attributes_for :translations
  default_scope :order => "priority DESC"

  validates :priority, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :name, presence: true, length: { maximum: 100 }
end
