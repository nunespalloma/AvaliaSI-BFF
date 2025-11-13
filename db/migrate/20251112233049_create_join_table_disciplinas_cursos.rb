class CreateJoinTableDisciplinasCursos < ActiveRecord::Migration[8.0]
  def change
    create_join_table :disciplinas, :cursos do |t|
      t.index [:disciplina_id, :curso_id]
      t.index [:curso_id, :disciplina_id]
    end
  end
end
