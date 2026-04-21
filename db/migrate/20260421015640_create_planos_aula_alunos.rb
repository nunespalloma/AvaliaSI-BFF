class CreatePlanosAulaAlunos < ActiveRecord::Migration[7.1]
  def change
    create_table :planos_aula_alunos do |t|
      t.string :matricula, null: false
      t.string :codigo_disciplina, null: false
      t.string :nome_disciplina, null: false
      t.string :turma, null: false
      t.references :semestre, null: false, foreign_key: true

      t.timestamps
    end

    add_index :planos_aula_alunos,
              [:matricula, :codigo_disciplina, :turma, :semestre_id],
              unique: true,
              name: 'idx_planos_aula_alunos_unico'
  end
end