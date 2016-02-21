class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :space_type
      t.string :space_size
      t.boolean :has_moving
      t.string :list_name
      t.text :desc
      t.string :address
      t.string :city
      t.string :state
      t.boolean :for_car
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
