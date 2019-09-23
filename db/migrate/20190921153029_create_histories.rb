class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.date :search_date
      t.string :category
      t.string :prefectures
      t.string :result
      t.references :user
      t.timestamps
    end
  end
end
