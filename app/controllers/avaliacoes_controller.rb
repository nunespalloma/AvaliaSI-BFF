class AvaliacoesController < ApplicationController
  def create
    aluno = Aluno.find(params[:aluno_id])
    plano = PlanoAulaAluno.find(avaliacao_params[:plano_aula_aluno_id])

    if plano.matricula.to_s.strip != aluno.matricula.to_s.strip
      return render json: {
        error: 'Este plano de aula não pertence ao aluno informado.'
      }, status: :unprocessable_entity
    end

    turma = Turma.joins(:disciplina)
                 .where(
                   nome: plano.turma.to_s.strip.upcase,
                   semestre_id: plano.semestre_id
                 )
                 .where('UPPER(disciplinas.codigo) = ?', plano.codigo_disciplina.to_s.strip.upcase)
                 .first

    if turma.blank?
      return render json: {
        error: 'Não foi possível avaliar esta turma porque ela ainda não foi cadastrada pela coordenação.'      
      }, status: :unprocessable_content
    end

    avaliacao_existente = Avaliacao.joins(:alunos)
                                   .where(turma_id: turma.id)
                                   .where(alunos: { id: aluno.id })
                                   .exists?

    if avaliacao_existente
      return render json: {
        error: 'Você já avaliou esta turma.'
      }, status: :unprocessable_entity
    end

    avaliacao = Avaliacao.new(
      turma: turma,
      avaliacao_geral: avaliacao_params[:avaliacao_geral],
      organizacao_conteudo: avaliacao_params[:organizacao_conteudo],
      quantidade_exercicios: avaliacao_params[:quantidade_exercicios],
      avaliacao_condizente: avaliacao_params[:avaliacao_condizente],
      professor_respeitoso: avaliacao_params[:professor_respeitoso],
      professor_solicito: avaliacao_params[:professor_solicito],
      assiduidade_professor: avaliacao_params[:assiduidade_professor],
      aspectos_gerais: avaliacao_params[:aspectos_gerais]
    )

    if avaliacao.save
      avaliacao.alunos << aluno

      render json: {
        message: 'Avaliação enviada com sucesso!',
        avaliacao_id: avaliacao.id
      }, status: :created
    else
      render_validation_error(avaliacao)
    end
  end

  private

  def avaliacao_params
    params.require(:avaliacao).permit(
      :plano_aula_aluno_id,
      :avaliacao_geral,
      :organizacao_conteudo,
      :quantidade_exercicios,
      :avaliacao_condizente,
      :professor_respeitoso,
      :professor_solicito,
      :assiduidade_professor,
      :aspectos_gerais
    )
  end
end