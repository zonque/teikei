ActiveAdmin.register Commodity do

  filter :commodity_group
  filter :updated_at
  filter :name

  index do |commodity|
    column :name do |commodity|
      link_to commodity.name, [:admin, commodity]
    end

    column :priority
    column :commodity_group
  end

  show do
    panel "Details" do
      attributes_table_for commodity do
        row :id
        row :name
        row :priority
        row :created_at
        row :updated_at
      end
    end

    panel "Translations" do
      table_for(commodity.translations) do
        column :locale
        column :title
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :commodity_group, as: :select
      f.input :name
      f.input :priority
    end

    f.buttons
  end

  sidebar "Details", :only => :show do
    attributes_table_for commodity do
      row :name
      row :priority
      row :updated_at
    end
  end

end

