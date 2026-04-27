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
        passagem_conteudo: 0,
        quantidade_exercicios: 0,
        avaliacao_condizente: 0,
        professor_respeitoso: 0,
        professor_solicito: 0,
        assiduidade_professor: 0,
        teoria_pratica: 0,
        percentual_trancou_turma: 0,
        percentual_acredita_passar: 0,
        nota_estrelas: 0,
        comentarios: [],
        motivos_trancamento: [],
        pontos_que_afligiram: []
      }
    end

    organizacao = media(avaliacoes.pluck(:organizacao_conteudo))
    passagem = media(avaliacoes.pluck(:passagem_conteudo))
    exercicios = media(avaliacoes.pluck(:quantidade_exercicios))
    condizente = media(avaliacoes.pluck(:avaliacao_condizente))
    respeito = media(avaliacoes.pluck(:professor_respeitoso))
    solicito = media(avaliacoes.pluck(:professor_solicito))
    assiduidade = media(avaliacoes.pluck(:assiduidade_professor))
    teoria_pratica = media(avaliacoes.pluck(:teoria_pratica))
    geral = media(avaliacoes.pluck(:avaliacao_geral))

    total = avaliacoes.count

    total_trancou = avaliacoes.where(trancou_turma: true).count
    percentual_trancou =
      total.zero? ? 0 : ((total_trancou.to_f / total) * 100).round(1)

    total_acredita = avaliacoes.where(acredita_passar: true).count
    percentual_acredita =
      total.zero? ? 0 : ((total_acredita.to_f / total) * 100).round(1)

    comentarios = avaliacoes
      .where.not(aspectos_gerais: [nil, ''])
      .pluck(:aspectos_gerais)

    motivos_trancamento = avaliacoes
      .where.not(porque_trancou: [nil, ''])
      .pluck(:porque_trancou)

    pontos_que_afligiram = avaliacoes
      .where.not(ponto_que_afligiu: [nil, ''])
      .pluck(:ponto_que_afligiu)

    render json: {
      organizacao_conteudo: organizacao,
      passagem_conteudo: passagem,
      quantidade_exercicios: exercicios,
      avaliacao_condizente: condizente,
      professor_respeitoso: respeito,
      professor_solicito: solicito,
      assiduidade_professor: assiduidade,
      teoria_pratica: teoria_pratica,
      percentual_trancou_turma: percentual_trancou,
      percentual_acredita_passar: percentual_acredita,
      nota_estrelas: geral,
      comentarios: comentarios,
      motivos_trancamento: motivos_trancamento,
      pontos_que_afligiram: pontos_que_afligiram
    }
  end

  private

  def media(valores)
    nums = valores.map { |v| v.to_f }
    return 0 if nums.empty?

    (nums.sum / nums.size).round(1)
  end
end