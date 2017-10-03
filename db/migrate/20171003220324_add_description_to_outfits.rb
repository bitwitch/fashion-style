class AddDescriptionToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_column :outfits, :description, :text
  end
end
