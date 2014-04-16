class ConvertCommodities < ActiveRecord::Migration
  def up
    vegetable_products = CommodityGroup.find("vegetable_products") rescue CommodityGroup.create(name: "vegetable_products")
    animal_products =    CommodityGroup.find("animal_products")    rescue CommodityGroup.create(name: "animal_products")
    beverages =          CommodityGroup.find("beverages")          rescue CommodityGroup.create(name: "beverages")

    Farm.all.each do |f|
      f.vegetable_products.each do |name|
        c = Commodity.find(name) rescue Commodity.create(name: name, commodity_group: vegetable_products)
        f.commodities << c
      end

      f.animal_products.each do |name|
        c = Commodity.find(name) rescue Commodity.create(name: name, commodity_group: animal_products)
        f.commodities << c
      end

      f.beverages.each do |name|
        c = Commodity.find(name) rescue Commodity.create(name: name, commodity_group: beverages)
        f.commodities << c
      end
    end
  end

  def down
  end
end
