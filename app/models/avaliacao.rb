class Avaliacao < ApplicationRecord
  self.table_name = 'avaliacaos'

  belongs_to :turma
  has_and_belongs_to_many :alunos, join_table: :alunos_avaliacaos

  validates :turma, presence: true
  validates :avaliacao_geral, presence: true
  validates :organizacao_conteudo, presence: true
  validates :quantidade_exercicios, presence: true
  validates :avaliacao_condizente, presence: true
  validates :assiduidade_professor, presence: true
  validates :professor_solicito, presence: true
  validates :professor_respeitoso, presence: true
end