class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: { message: '氏名は必ず入力してください' },
                   length: { maximum: 255, message: '氏名は255文字以内で入力してください' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: { message: 'メールアドレスは必ず入力してください' },
                    length: { maximum: 255, message: 'メールアドレスは255文字以内で入力してください' },
                    format: { with: VALID_EMAIL_REGEX , message: 'メールアドレスが正しい形式ではありません'},
                    uniqueness: { message: 'そのメールアドレスはすでに存在しています' }
  has_secure_password
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  validates :password, presence: { message: 'パスワードは必ず入力してください' },
                       length: { minimum: 8, message: '英数字8文字以上で入力してください' },
                       format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '英数字8文字以上で入力してください'}
end
