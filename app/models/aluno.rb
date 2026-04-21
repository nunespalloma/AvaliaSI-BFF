class Aluno < ApplicationRecord
    self.table_name = 'alunos'

    belongs_to :usuario, inverse_of: :aluno

    has_and_belongs_to_many :turmas
    has_and_belongs_to_many :avaliacaos, join_table: :alunos_avaliacaos
    
    validates :matricula, presence: true, uniqueness: true

    before_validation :normalizar_matricula

    private

    def normalizar_matricula
        self.matricula = matricula.to_s.strip
    end
end
