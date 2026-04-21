class PlanoAulaAluno < ApplicationRecord
  self.table_name = 'planos_aula_alunos'

  belongs_to :semestre

  validates :matricula, presence: true
  validates :codigo_disciplina, presence: true
  validates :nome_disciplina, presence: true
  validates :turma, presence: true

  validates :matricula, uniqueness: {
    scope: [:codigo_disciplina, :turma, :semestre_id],
    message: 'já possui esse plano de aula cadastrado para o semestre'
  }

  before_validation :normalizar_campos

  private

  def normalizar_campos
    self.matricula = matricula.to_s.strip
    self.codigo_disciplina = codigo_disciplina.to_s.strip.upcase
    self.nome_disciplina = nome_disciplina.to_s.strip.upcase
    self.turma = turma.to_s.strip.upcase
  end
end