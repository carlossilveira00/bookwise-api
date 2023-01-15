class ChangeBookTittleColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :books, :title, :tittle
  end
end
