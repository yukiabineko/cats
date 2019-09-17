class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.date :save_date
      t.string :ideal_weight
      t.float :result_weight
      t.string :result
      t.references :cat

      t.timestamps
    end
  end
end
