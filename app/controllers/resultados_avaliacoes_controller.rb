class ResultadosAvaliacoesController < ApplicationController
  def index
    turmas = Turma
      .joins(:avaliacaos, :disciplina)
      .left_joins(:professor)
      .includes(:disciplina, :professor)
      .distinct
      .order('disciplinas.nome ASC, turmas.nome ASC')

    render json: turmas.map { |turma|
      {
        id: turma.id,
        disciplina: turma.disciplina&.nome.to_s,
        turma: turma.nome.to_s,
        professor: turma.professor&.nome.to_s
      }
    }
  end

  def show
    turma = Turma.find(params[:id])
    avaliacoes = turma.avaliacaos

    if avaliacoes.empty?
      return render json: {
        organizacao_conteudo: 0,
        quantidade_exercicios: 0,
        avaliacao_condizente: 0,
        professor_respeitoso: 0,
        professor_solicito: 0,
        assiduidade_professor: 0,
        nota_estrelas: 0,
        comentarios: []
      }
    end

    organizacao = media(avaliacoes.pluck(:organizacao_conteudo))
    exercicios = media(avaliacoes.pluck(:quantidade_exercicios))
    condizente = media(avaliacoes.pluck(:avaliacao_condizente))
    respeito = media(avaliacoes.pluck(:professor_respeitoso))
    solicito = media(avaliacoes.pluck(:professor_solicito))
    assiduidade = media(avaliacoes.pluck(:assiduidade_professor))
    geral = media(avaliacoes.pluck(:avaliacao_geral))

    comentarios = avaliacoes
      .where.not(aspectos_gerais: [nil, ''])
      .pluck(:aspectos_gerais)

    render json: {
      organizacao_conteudo: organizacao,
      quantidade_exercicios: exercicios,
      avaliacao_condizente: condizente,
      professor_respeitoso: respeito,
      professor_solicito: solicito,
      assiduidade_professor: assiduidade,
      nota_estrelas: geral,
      comentarios: comentarios
    }
  end

  private

  def media(valores)
    nums = valores.map { |v| v.to_f }
    return 0 if nums.empty?

    (nums.sum / nums.size).round(1)
  end
end