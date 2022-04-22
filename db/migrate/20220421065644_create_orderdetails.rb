class CreateOrderdetails < ActiveRecord::Migration[7.0]
  def change
    create_table :orderdetails do |t|
      t.string :order_id
      t.string :food_id
      t.integer :qty
      t.float :price

      t.timestamps
    end
  end
end
