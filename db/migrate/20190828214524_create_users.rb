class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.binary :image
      t.string :name,null: false
      t.string :email,null: false
      t.string :password_digest
      t.boolean :admin,default:false
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
