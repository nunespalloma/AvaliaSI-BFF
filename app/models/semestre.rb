class Semestre < ApplicationRecord
  has_many :turmas, dependent: :destroy

  validates :ano, presence: true,
                  numericality: {
                    only_integer: true,
                    greater_than_or_equal_to: 2000,
                    less_than_or_equal_to: 2100
                  }

  validates :periodo, presence: true,
                      numericality: { only_integer: true },
                      inclusion: { in: [1, 2], message: 'deve ser 1 ou 2' }

  validates :periodo, uniqueness: {
    scope: :ano,
    message: 'já existe para este ano'
  }

  def nome
    "#{ano}.#{periodo}"
  end
end