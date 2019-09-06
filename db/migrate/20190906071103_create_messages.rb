class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :message_content
      t.integer :user_id
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
