class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.references :commodity_group
      t.string :name
      t.integer :priority

      t.timestamps
    end
    add_index :commodities, :commodity_group_id
  end
end
