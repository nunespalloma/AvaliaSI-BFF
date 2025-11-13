class CreateJoinTableAlunosTurmas < ActiveRecord::Migration[8.0]
  def change
    create_join_table :alunos, :turmas do |t|
      # Índices ajudam na performance e garantem unicidade do par
      t.index [:aluno_id, :turma_id], unique: true
      t.index [:turma_id, :aluno_id]
    end
  end
end
