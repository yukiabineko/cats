class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :post_title, null:false
      t.string :post_content, null:false
      t.string :category
      t.boolean :public,default:true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
