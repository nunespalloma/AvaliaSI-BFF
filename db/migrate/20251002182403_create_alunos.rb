class CreateAlunos < ActiveRecord::Migration[8.0]
  def change
    create_table :alunos do |t|
      t.references :usuario, null: false, foreign_key: true, index: { unique: true }
      t.string :matricula, null: false
      t.timestamps
    end

    add_index :alunos, :matricula, unique: true
  end
end
