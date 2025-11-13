class CreateAvaliacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :avaliacaos do |t|
      t.boolean :trancou_turma, default: false, null: false
      t.string  :porque_trancou
      t.string  :organizacao_conteudo
      t.string  :passagem_conteudo
      t.string  :quantidade_exercicios
      t.string  :teoria_pratica
      t.string  :avaliacao_condizente
      t.string  :assiduidade_professor
      t.string  :professor_solicito
      t.string  :professor_respeitoso
      t.boolean :acredita_passar, default: false, null: false
      t.string  :ponto_que_afligiu
      t.string  :aspectos_gerais

      t.references :turma, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
