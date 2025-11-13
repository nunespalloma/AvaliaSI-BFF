class CreateCursos < ActiveRecord::Migration[8.0]
  def change
    create_table :cursos do |t|
      t.string :nome

      t.timestamps
    end

    add_index :cursos, :nome
  end
end
