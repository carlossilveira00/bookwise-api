class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :user_library, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :tag

      t.timestamps
    end
  end
end
