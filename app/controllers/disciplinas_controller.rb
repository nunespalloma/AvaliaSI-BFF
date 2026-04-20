class DisciplinasController < ApplicationController
  def index
    disciplinas = Disciplina.order(:nome)

    render json: disciplinas.map { |disciplina|
      {
        id: disciplina.id,
        nome: disciplina.nome,
        codigo: disciplina.codigo
      }
    }
  end

  def create
    disciplina = Disciplina.new(disciplina_params)

    if disciplina.save
      render json: {
        id: disciplina.id,
        nome: disciplina.nome,
        codigo: disciplina.codigo,
        message: 'Disciplina criada com sucesso'
      }, status: :created
    else
      render_validation_error(disciplina)
    end
  end

  def update
    disciplina = Disciplina.find(params[:id])

    if disciplina.update(disciplina_params)
      render json: {
        id: disciplina.id,
        nome: disciplina.nome,
        codigo: disciplina.codigo,
        message: 'Disciplina atualizada com sucesso'
      }
    else
      render_validation_error(disciplina)
    end
  end

  def destroy
    disciplina = Disciplina.find(params[:id])
    disciplina.destroy!

    render json: { message: 'Disciplina excluída com sucesso' }
  end

  private

  def disciplina_params
    params.require(:disciplina).permit(:nome, :codigo)
  end
end