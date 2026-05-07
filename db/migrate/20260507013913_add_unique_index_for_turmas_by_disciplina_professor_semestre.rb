class AddUniqueIndexForTurmasByDisciplinaProfessorSemestre < ActiveRecord::Migration[8.0]
  def change
    remove_index :turmas, :nome if index_exists?(:turmas, :nome)

    add_index :turmas,
      [:nome, :disciplina_id, :professor_id, :semestre_id],
      unique: true,
      name: 'idx_turmas_disciplina_professor_semestre'
  end
end