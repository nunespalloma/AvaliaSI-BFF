class ImportacoesController < ApplicationController
  def plano_aulas
    arquivo = params[:arquivo]
    semestre_id = params[:semestre_id]

    if arquivo.blank?
      return render json: {
        sucesso: false,
        message: 'Arquivo CSV é obrigatório.',
        erros: []
      }, status: :unprocessable_entity
    end

    if semestre_id.blank?
      return render json: {
        sucesso: false,
        message: 'Semestre é obrigatório.',
        erros: []
      }, status: :unprocessable_entity
    end

    semestre = Semestre.find(semestre_id)

    resultado = ImportarPlanoAulasService.new(
      arquivo: arquivo,
      semestre: semestre
    ).call

    status = resultado[:sucesso] ? :ok : :unprocessable_entity
    render json: resultado, status: status
  end
end