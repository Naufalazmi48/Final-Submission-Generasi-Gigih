class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
