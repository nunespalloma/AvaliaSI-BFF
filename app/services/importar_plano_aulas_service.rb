require 'csv'

class ImportarPlanoAulasService
  def initialize(arquivo:, semestre:)
    @arquivo = arquivo
    @semestre = semestre
  end

  def call
    linhas_processadas = 0
    importados = 0
    erros = []

    begin
      conteudo = @arquivo.read
      conteudo = conteudo.force_encoding('UTF-8')
      conteudo = remover_bom(conteudo)

      csv = CSV.parse(
        conteudo,
        headers: true,
        col_sep: ';'
      )
    rescue => e
      return {
        sucesso: false,
        message: 'Não foi possível ler o arquivo CSV.',
        total_linhas: 0,
        total_importados: 0,
        total_erros: 1,
        erros: [e.message]
      }
    end

    headers = csv.headers.map { |h| normalizar_header(h) }

    colunas_obrigatorias = %w[
      matricula
      codigodisciplina
      nomedisciplina
      turma
    ]

    colunas_faltando = colunas_obrigatorias - headers

    if colunas_faltando.any?
      return {
        sucesso: false,
        message: 'O CSV não possui todas as colunas obrigatórias.',
        total_linhas: 0,
        total_importados: 0,
        total_erros: 1,
        erros: [
          "Colunas obrigatórias: MATRICULA;CODIGODISCIPLINA;NOMEDISCIPLINA;TURMA. Faltando: #{colunas_faltando.join(', ')}"
        ]
      }
    end

    csv.each_with_index do |row, index|
      numero_linha = index + 2
      linhas_processadas += 1

      begin
        matricula = valor(row, 'matricula')
        codigo_disciplina = valor(row, 'codigodisciplina')
        nome_disciplina = valor(row, 'nomedisciplina')
        turma = valor(row, 'turma')

        if matricula.blank? || codigo_disciplina.blank? || nome_disciplina.blank? || turma.blank?
          raise "Linha #{numero_linha}: matrícula, código da disciplina, nome da disciplina e turma são obrigatórios."
        end

        registro = PlanoAulaAluno.find_or_initialize_by(
          matricula: matricula.to_s.strip,
          codigo_disciplina: codigo_disciplina.to_s.strip.upcase,
          turma: turma.to_s.strip.upcase,
          semestre_id: @semestre.id
        )

        registro.nome_disciplina = nome_disciplina.to_s.strip.upcase
        registro.save!

        importados += 1
      rescue ActiveRecord::RecordInvalid => e
        erros << "Linha #{numero_linha}: #{e.record.errors.full_messages.join(', ')}"
      rescue => e
        erros << e.message
      end
    end

    {
      sucesso: erros.empty?,
      message: erros.empty? ? 'Planos de aula importados com sucesso.' : 'Importação concluída com pendências.',
      total_linhas: linhas_processadas,
      total_importados: importados,
      total_erros: erros.size,
      erros: erros
    }
  end

  private

  def valor(row, nome_coluna)
    indice = row.headers.find { |h| normalizar_header(h) == nome_coluna }
    row[indice].to_s.strip if indice.present?
  end

  def normalizar_header(header)
    header.to_s
          .strip
          .downcase
          .tr('áàãâä', 'a')
          .tr('éèêë', 'e')
          .tr('íìîï', 'i')
          .tr('óòõôö', 'o')
          .tr('úùûü', 'u')
          .gsub(/[^\w]/, '')
  end

  def remover_bom(texto)
    texto.sub("\uFEFF", '')
  end
end