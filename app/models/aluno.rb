class Aluno < ApplicationRecord
    belongs_to :usuario, inverse_of: :aluno

    has_and_belongs_to_many :turmas
    has_and_belongs_to_many :avaliacaos, join_table: :alunos_avaliacaos
    
    validates :matricula, presence: true, uniqueness: true
end
