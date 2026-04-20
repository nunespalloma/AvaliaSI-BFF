class TurmasController < ApplicationController
  def index
    turmas = Turma
      .includes(:disciplina, :professor, :semestre)
      .order('semestres.ano DESC, semestres.periodo DESC, disciplinas.nome ASC, turmas.nome ASC')
      .references(:semestre, :disciplina)

    render json: turmas.map { |turma| turma_json(turma) }
  end

  def create
    turma = Turma.new(turma_params)

    if turma.save
      turma.reload
      render json: turma_json(turma).merge(message: 'Turma criada com sucesso'), status: :created
    else
      render_validation_error(turma)
    end
  end

  def update
    turma = Turma.find(params[:id])

    if turma.update(turma_params)
      turma.reload
      render json: turma_json(turma).merge(message: 'Turma atualizada com sucesso')
    else
      render_validation_error(turma)
    end
  end

  def destroy
    turma = Turma.find(params[:id])
    turma.destroy!

    render json: { message: 'Turma excluída com sucesso' }
  end

  private

  def turma_params
    params.require(:turma).permit(
      :nome,
      :disciplina_id,
      :professor_id,
      :semestre_id
    )
  end

  def turma_json(turma)
    {
      id: turma.id,
      nome: turma.nome,

      disciplina_id: turma.disciplina_id,
      disciplina_nome: turma.disciplina&.nome,

      professor_id: turma.professor_id,
      professor_nome: turma.professor&.nome,

      semestre_id: turma.semestre_id,
      semestre_ano: turma.semestre&.ano.to_s,
      semestre_periodo: turma.semestre&.periodo.to_s,
      semestre_nome: turma.semestre.present? ? "#{turma.semestre.ano}.#{turma.semestre.periodo}" : nil
    }
  end
end