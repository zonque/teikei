ActiveAdmin.register CommodityGroup do

  filter :updated_at
  filter :name

  index do |commodity_group|
    column :name do |commodity_group|
      link_to commodity_group.name, [:admin, commodity_group]
    end

    column :priority
  end

  show do
    panel "Details" do
      attributes_table_for commodity_group do
        row :id
        row :name
        row :priority
        row :created_at
        row :updated_at
      end
    end

    panel "Commodities" do
      table_for(commodity_group.commodities) do
        column :name do |c|
          link_to c.name, [:admin, c]
        end
        column :priority
      end
    end

    panel "Translations" do
      table_for(commodity_group.translations) do
        column :locale
        column :title
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :priority
    end

    f.inputs "Translations" do
      f.has_many :translations do |t|
        t.input :locale
        t.input :title
      end
    end

    f.buttons
  end

  sidebar "Details", :only => :show do
    attributes_table_for commodity_group do
      row :name
      row :priority
      row :updated_at
    end
  end

end

