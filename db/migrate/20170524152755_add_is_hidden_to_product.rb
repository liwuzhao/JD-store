class AddIsHiddenToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :is_public, :boolean, default: true

  end
end
