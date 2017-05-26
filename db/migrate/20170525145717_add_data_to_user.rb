class AddDataToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :truename, :string
    add_column :users, :nickname, :string
    add_column :users, :address, :string
    add_column :users, :numbers, :string
  end
end
