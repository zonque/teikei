class CommoditiesFarms < ActiveRecord::Migration
  def change
    create_table :commodities_farms do |t|
      t.belongs_to :commodity
      t.belongs_to :farm
    end
  end
end
