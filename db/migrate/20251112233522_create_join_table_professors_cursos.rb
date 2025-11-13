class CreateJoinTableProfessorsCursos < ActiveRecord::Migration[8.0]
  def change
    create_join_table :professors, :cursos do |t|
      t.index [:professor_id, :curso_id]
      t.index [:curso_id, :professor_id]
    end
  end
end
