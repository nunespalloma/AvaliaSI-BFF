class CreateTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :turmas do |t|
      t.string :nome, null: false
      t.references :disciplina, null: false, foreign_key: true
      t.references :professor, null: false, foreign_key: { to_table: :professores }
      t.references :semestre,  null: false, foreign_key: true

      t.timestamps
    end

    add_index :turmas, :nome
  end
end
