class User < ApplicationRecord
    has_secure_password                                                                               #パスワード
    mount_uploader :image,ImageUploader                                                               #画像処理用
    before_save { self.email = email.downcase }                                                       #大文字小文字処理

    validates :name,  presence: true, length: { maximum: 50 }                                         #名前バリデーション

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i                                          #メールアドレスパターン
    validates :email, presence: true, length: { maximum: 100 },                                       #メールアドレスバリデーション
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true 
    validates :password, presence: true, length: { minimum: 6 }                                       #パスワードバリデーション            


end
