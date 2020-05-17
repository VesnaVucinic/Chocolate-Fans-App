class CreateChocolates < ActiveRecord::Migration[6.0]
  def change
    create_table :chocolates do |t|
      t.string :category
      t.string :description
      t.belongs_to :brand, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
