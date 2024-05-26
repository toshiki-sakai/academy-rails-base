class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_one_attached :image
  has_many :learning_data

  validates :name, presence: { message: '氏名は必ず入力してください' },
                   length: { maximum: 255, message: '氏名は255文字以内で入力してください' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: { message: 'メールアドレスは必ず入力してください' },
                    length: { maximum: 255, message: 'メールアドレスは255文字以内で入力してください' },
                    format: { with: VALID_EMAIL_REGEX , message: 'メールアドレスが正しい形式ではありません'},
                    uniqueness: { message: 'そのメールアドレスはすでに存在しています' }
  has_secure_password
  VALID_PASSWORD_REGEX =/(?=.{8,})(?=.*\d+.*)(?=.*[a-zA-Z]+.*)[a-zA-Z0-9.,?!@#$%&-]/i
  validates :password, presence: { message: 'パスワードは必ず入力してください' },
                       format: { with: VALID_PASSWORD_REGEX, message: '英数字8文字以上で入力してください'},
                       if: :password_required?
  validates :introduction, presence: { message: '自己紹介は必ず入力してください' }, length: { minimum: 50, maximum: 200, message: "自己紹介は50文字以上200文字以下で入力してください"}

  def password_required?
    new_record? || password.present?
  end
end
