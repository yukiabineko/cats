class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.string :reply_content
      t.integer :user_id
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
