class Disciplina < ApplicationRecord
    has_many :turmas, dependent: :destroy
    has_and_belongs_to_many :cursos

    validates :codigo, presence: true, uniqueness: true
    validates :nome, presence: true
end
