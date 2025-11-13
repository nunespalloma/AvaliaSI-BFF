class Curso < ApplicationRecord
    has_and_belongs_to_many :prefessors
    has_and_belongs_to_many :disciplinas
end
