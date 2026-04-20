class Professor < ApplicationRecord
  self.table_name = 'professores'

  has_many :turmas, dependent: :destroy
  has_and_belongs_to_many :cursos

  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  before_validation :normalizar_nome

  private

  def normalizar_nome
    self.nome = nome.to_s.strip
  end
end