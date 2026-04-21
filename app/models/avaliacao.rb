class Avaliacao < ApplicationRecord
  self.table_name = 'avaliacaos'
  
  belongs_to :turma
  has_and_belongs_to_many :alunos, join_table: :alunos_avaliacaos

  validates :turma, presence: true
end
