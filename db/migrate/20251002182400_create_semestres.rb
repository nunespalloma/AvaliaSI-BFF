class CreateSemestres < ActiveRecord::Migration[8.0]
 def change
    create_table :semestres do |t|
      t.integer :ano, null: false
      t.integer :periodo, null: false

      t.timestamps
    end

    # índice opcional para evitar duplicação de semestre (ano + período)
    add_index :semestres, [:ano, :periodo], unique: true
  end
end
