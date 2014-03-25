class Commodity < ActiveRecord::Base
  include Translatable

  belongs_to :commodity_group
  has_many :translations, :as => :translatable, :dependent => :destroy

  attr_accessible :name, :priority, :translations_attributes, :commodity_group
  accepts_nested_attributes_for :translations
  default_scope :order => "priority DESC"

  validates :priority, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :commodity_group, presence: true
end
