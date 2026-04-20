class SemestresController < ApplicationController
  def index
    semestres = Semestre.order(ano: :desc, periodo: :desc)

    render json: semestres.map { |semestre|
      {
        id: semestre.id,
        ano: semestre.ano.to_s,
        periodo: semestre.periodo.to_s
      }
    }
  end

  def create
    semestre = Semestre.new(semestre_params)

    if semestre.save
      render json: {
        id: semestre.id,
        ano: semestre.ano.to_s,
        periodo: semestre.periodo.to_s,
        message: 'Semestre criado com sucesso'
      }, status: :created
    else
      render_validation_error(semestre)
    end
  end

  def update
    semestre = Semestre.find(params[:id])

    if semestre.update(semestre_params)
      render json: {
        id: semestre.id,
        ano: semestre.ano.to_s,
        periodo: semestre.periodo.to_s,
        message: 'Semestre atualizado com sucesso'
      }
    else
      render_validation_error(semestre)
    end
  end

  def destroy
    semestre = Semestre.find(params[:id])
    semestre.destroy!

    render json: { message: 'Semestre excluído com sucesso' }
  end

  private

  def semestre_params
    params.require(:semestre).permit(:ano, :periodo)
  end
end