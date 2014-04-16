class CreateCommodityGroups < ActiveRecord::Migration
  def change
    create_table :commodity_groups do |t|
      t.string :name
      t.integer :priority

      t.timestamps
    end
  end
end
