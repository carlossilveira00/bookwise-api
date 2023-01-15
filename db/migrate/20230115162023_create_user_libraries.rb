class CreateUserLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :user_libraries do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.date :started_date
      t.date :ended_date

      t.timestamps
    end
  end
end
