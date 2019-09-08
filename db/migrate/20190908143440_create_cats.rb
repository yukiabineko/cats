class CreateCats < ActiveRecord::Migration[5.1]
  def change
    create_table :cats do |t|
      t.string :cat_name
      t.binary :cat_image
      t.string :cat_sex
      t.integer :cat_weight
      t.integer :cat_age
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
