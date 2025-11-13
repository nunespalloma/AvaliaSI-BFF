class Usuario < ApplicationRecord
    has_secure_password

  has_one :aluno, dependent: :destroy, inverse_of: :usuario
  has_one :coordenacao, dependent: :destroy, inverse_of: :usuario

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
