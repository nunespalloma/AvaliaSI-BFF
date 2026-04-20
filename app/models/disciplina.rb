class Disciplina < ApplicationRecord
    has_many :turmas, dependent: :destroy
    has_and_belongs_to_many :cursos

    validates :codigo, presence: true, uniqueness: { case_sensitive: false }
    validates :nome, presence: true

    before_validation :normalizar_campos

    private

    def normalizar_campos
      self.nome = nome.to_s.strip
      self.codigo = codigo.to_s.strip.upcase
    end
end
