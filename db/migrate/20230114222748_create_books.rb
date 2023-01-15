class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :pages
      t.string :author
      t.string :category
      t.string :thumbnail_url
      t.string :publisher
      t.string :ISBN
      t.date :published_date
      t.integer :rating

      t.timestamps
    end
  end
end
