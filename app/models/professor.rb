class Professor < ApplicationRecord
    has_many :turmas, dependent: :destroy
    has_and_belongs_to_many :cursos

    validates :nome, presence: true
end
