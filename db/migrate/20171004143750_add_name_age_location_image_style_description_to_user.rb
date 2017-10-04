class AddNameAgeLocationImageStyleDescriptionToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_column :users, :location, :string
    add_column :users, :image, :string
    add_column :users, :style_description, :string
  end
end
