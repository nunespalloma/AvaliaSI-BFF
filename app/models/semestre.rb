class Semestre < ApplicationRecord
    has_many :turmas, dependent: :destroy

    validates :ano, presence: true
    validates :periodo, presence: true
    validates :periodo, inclusion: { in: [1, 2], message: "deve ser 1 ou 2" }
end
