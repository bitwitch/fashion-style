class CreateOutfits < ActiveRecord::Migration[5.1]
  def change
    create_table :outfits do |t|
      t.string :name
      t.integer :user_id 
      t.string :accessories_url 
      t.string :outerwear_url 
      t.string :tops_url 
      t.string :pants_url 
      t.string :shoes_url 
      
      t.timestamps
    end
  end
end
