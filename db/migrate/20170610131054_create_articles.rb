class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.text :summary
      t.string :image
      t.boolean :is_hidden,   default: true

      t.timestamps
    end
  end
end
