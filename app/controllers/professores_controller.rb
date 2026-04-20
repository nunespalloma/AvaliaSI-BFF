class ProfessoresController < ApplicationController
  def index
    professores = Professor.order(:nome)

    render json: professores.map { |professor|
      {
        id: professor.id,
        nome: professor.nome
      }
    }
  end

  def create
    professor = Professor.new(professor_params)

    if professor.save
      render json: {
        id: professor.id,
        nome: professor.nome,
        message: 'Professor criado com sucesso'
      }, status: :created
    else
      render_validation_error(professor)
    end
  end

  def update
    professor = Professor.find(params[:id])

    if professor.update(professor_params)
      render json: {
        id: professor.id,
        nome: professor.nome,
        message: 'Professor atualizado com sucesso'
      }
    else
      render_validation_error(professor)
    end
  end

  def destroy
    professor = Professor.find(params[:id])
    professor.destroy!

    render json: { message: 'Professor excluído com sucesso' }
  end

  private

  def professor_params
    params.require(:professor).permit(:nome)
  end
end