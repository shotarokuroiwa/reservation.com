class User < ApplicationRecord
  has_one_attached :icon
  has_secure_password

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  attr_accessor :current_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  validate :current_password_is_correct, if: :account_update?
  private

  def account_update?
    password.present? || will_save_change_to_email?
  end

  def current_password_is_correct
    if current_password.blank?
      errors.add(:current_password, "を入力してください")
    elsif !authenticate(current_password)
      errors.add(:current_password, "が正しくありません")
    end
  end
end
