class CreateBases < ActiveRecord::Migration[5.1]
  def change
    create_table :bases do |t|
      t.float :data_age
      t.float :min_weight
      t.float :max_weight

      t.timestamps
    end
  end
end
