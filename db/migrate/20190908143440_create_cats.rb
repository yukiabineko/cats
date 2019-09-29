class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string :cat_name,null: false
      t.binary :cat_image
      t.string :cat_sex
      t.float :cat_weight,null: false
      t.integer :cat_age,null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
