class Turma < ApplicationRecord
  self.table_name = 'turmas'

  belongs_to :disciplina
  belongs_to :professor, optional: true
  belongs_to :semestre
  has_and_belongs_to_many :alunos
  has_many :avaliacaos, dependent: :destroy

  validates :nome, presence: true
  validates :nome, uniqueness: {
    scope: [:disciplina_id, :professor_id, :semestre_id],
    message: 'já existe para esta disciplina, professor e semestre'
  }

  before_validation :normalizar_nome

  private

  def normalizar_nome
    self.nome = nome.to_s.strip.upcase
  end
end