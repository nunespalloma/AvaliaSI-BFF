class FixAvaliacaosForStudentEvaluations < ActiveRecord::Migration[8.0]
  def up
    if foreign_key_exists?(:avaliacaos, :turmas)
      remove_foreign_key :avaliacaos, :turmas
    end

    if index_exists?(:avaliacaos, :turma_id, unique: true, name: 'index_avaliacaos_on_turma_id')
      remove_index :avaliacaos, name: 'index_avaliacaos_on_turma_id'
    end

    unless index_exists?(:avaliacaos, :turma_id, name: 'index_avaliacaos_on_turma_id')
      add_index :avaliacaos, :turma_id, name: 'index_avaliacaos_on_turma_id'
    end

    unless foreign_key_exists?(:avaliacaos, :turmas)
      add_foreign_key :avaliacaos, :turmas
    end

    unless column_exists?(:avaliacaos, :avaliacao_geral)
      add_column :avaliacaos, :avaliacao_geral, :integer
    end
  end

  def down
    remove_column :avaliacaos, :avaliacao_geral if column_exists?(:avaliacaos, :avaliacao_geral)

    remove_foreign_key :avaliacaos, :turmas if foreign_key_exists?(:avaliacaos, :turmas)

    if index_exists?(:avaliacaos, :turma_id, name: 'index_avaliacaos_on_turma_id')
      remove_index :avaliacaos, name: 'index_avaliacaos_on_turma_id'
    end

    add_index :avaliacaos, :turma_id, unique: true, name: 'index_avaliacaos_on_turma_id'

    add_foreign_key :avaliacaos, :turmas unless foreign_key_exists?(:avaliacaos, :turmas)
  end
end