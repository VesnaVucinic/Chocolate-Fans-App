class AddNameToChocolates < ActiveRecord::Migration[6.0]
  def change
    add_column :chocolates, :title, :string
  end
end
