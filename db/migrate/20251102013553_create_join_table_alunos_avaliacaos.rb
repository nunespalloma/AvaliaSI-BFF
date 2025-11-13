class CreateJoinTableAlunosAvaliacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :alunos_avaliacaos, id: false do |t|
      t.bigint :aluno_id,      null: false
      t.bigint :avaliacao_id,  null: false
      t.timestamps
    end

    add_index :alunos_avaliacaos, [:aluno_id, :avaliacao_id], unique: true, name: "idx_alunos_avaliacaos_unique"
    add_index :alunos_avaliacaos, [:avaliacao_id, :aluno_id], name: "idx_alunos_avaliacaos_reverse"

    add_foreign_key :alunos_avaliacaos, :alunos,     column: :aluno_id
    add_foreign_key :alunos_avaliacaos, :avaliacaos, column: :avaliacao_id
  end
end
