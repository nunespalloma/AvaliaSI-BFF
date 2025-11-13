class Coordenacao < ApplicationRecord
  belongs_to :usuario, inverse_of: :coordenacao
end
