class AvaliacoesDisponiveisController < ApplicationController
  def index
    aluno = Aluno.find(params[:aluno_id])

    planos = PlanoAulaAluno
      .includes(:semestre)
      .where(matricula: aluno.matricula)
      .order('semestre_id DESC, nome_disciplina ASC, turma ASC')

    resultado = planos.map do |plano|
      {
        id: plano.id,
        disciplina: plano.nome_disciplina,
        codigo_disciplina: plano.codigo_disciplina,
        turma: plano.turma,
        semestre: "#{plano.semestre.ano}.#{plano.semestre.periodo}",
        avaliada: avaliacao_existe?(aluno, plano)
      }
    end

    render json: resultado
  end

  private

  def avaliacao_existe?(aluno, plano)
    turma = Turma.joins(:disciplina)
                 .where(
                   nome: plano.turma.to_s.strip.upcase,
                   semestre_id: plano.semestre_id
                 )
                 .where('UPPER(disciplinas.codigo) = ?', plano.codigo_disciplina.to_s.strip.upcase)
                 .first

    return false if turma.blank?

    Avaliacao.joins(:alunos)
             .where(turma_id: turma.id)
             .where(alunos: { id: aluno.id })
             .exists?
  end
end