class Turma < ApplicationRecord
    belongs_to :disciplina
    belongs_to :professor
    belongs_to :semestre
    has_and_belongs_to_many :alunos
    has_many :avaliacaos, dependent: :destroy

    validates :nome, presence: true
end
