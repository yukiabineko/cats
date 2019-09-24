class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.boolean :save_check
      t.string :facility_name
      t.string :prefectures
      t.string :phone_number
      t.references :user
      t.timestamps
    end
  end
end
