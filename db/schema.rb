# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_04_28_011500) do
  create_table "alunos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.string "matricula", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matricula"], name: "index_alunos_on_matricula", unique: true
    t.index ["usuario_id"], name: "index_alunos_on_usuario_id", unique: true
  end

  create_table "alunos_avaliacaos", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.bigint "avaliacao_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aluno_id", "avaliacao_id"], name: "idx_alunos_avaliacaos_unique", unique: true
    t.index ["avaliacao_id", "aluno_id"], name: "idx_alunos_avaliacaos_reverse"
  end

  create_table "alunos_turmas", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.bigint "turma_id", null: false
    t.index ["aluno_id", "turma_id"], name: "index_alunos_turmas_on_aluno_id_and_turma_id", unique: true
    t.index ["turma_id", "aluno_id"], name: "index_alunos_turmas_on_turma_id_and_aluno_id"
  end

  create_table "avaliacaos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "trancou_turma", default: false, null: false
    t.string "porque_trancou"
    t.string "organizacao_conteudo"
    t.string "passagem_conteudo"
    t.string "quantidade_exercicios"
    t.string "teoria_pratica"
    t.string "avaliacao_condizente"
    t.string "assiduidade_professor"
    t.string "professor_solicito"
    t.string "professor_respeitoso"
    t.boolean "acredita_passar", default: false, null: false
    t.string "ponto_que_afligiu"
    t.string "aspectos_gerais"
    t.bigint "turma_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "avaliacao_geral"
    t.index ["turma_id"], name: "index_avaliacaos_on_turma_id"
  end

  create_table "cursos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_cursos_on_nome"
  end

  create_table "cursos_disciplinas", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "disciplina_id", null: false
    t.bigint "curso_id", null: false
    t.index ["curso_id", "disciplina_id"], name: "index_cursos_disciplinas_on_curso_id_and_disciplina_id"
    t.index ["disciplina_id", "curso_id"], name: "index_cursos_disciplinas_on_disciplina_id_and_curso_id"
  end

  create_table "cursos_professors", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "professor_id", null: false
    t.bigint "curso_id", null: false
    t.index ["curso_id", "professor_id"], name: "index_cursos_professors_on_curso_id_and_professor_id"
    t.index ["professor_id", "curso_id"], name: "index_cursos_professors_on_professor_id_and_curso_id"
  end

  create_table "disciplinas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_disciplinas_on_codigo", unique: true
  end

  create_table "planos_aula_alunos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "matricula", null: false
    t.string "codigo_disciplina", null: false
    t.string "nome_disciplina", null: false
    t.string "turma", null: false
    t.bigint "semestre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matricula", "codigo_disciplina", "turma", "semestre_id"], name: "idx_planos_aula_alunos_unico", unique: true
    t.index ["semestre_id"], name: "index_planos_aula_alunos_on_semestre_id"
  end

  create_table "professores", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semestres", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "ano", null: false
    t.integer "periodo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ano", "periodo"], name: "index_semestres_on_ano_and_periodo", unique: true
  end

  create_table "turmas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome", null: false
    t.bigint "disciplina_id", null: false
    t.bigint "professor_id", null: false
    t.bigint "semestre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disciplina_id"], name: "index_turmas_on_disciplina_id"
    t.index ["nome"], name: "index_turmas_on_nome"
    t.index ["professor_id"], name: "index_turmas_on_professor_id"
    t.index ["semestre_id"], name: "index_turmas_on_semestre_id"
  end

  create_table "usuarios", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email", null: false
    t.boolean "is_coordenacao", default: false, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  add_foreign_key "alunos", "usuarios"
  add_foreign_key "alunos_avaliacaos", "alunos"
  add_foreign_key "alunos_avaliacaos", "avaliacaos"
  add_foreign_key "avaliacaos", "turmas"
  add_foreign_key "planos_aula_alunos", "semestres"
  add_foreign_key "turmas", "disciplinas"
  add_foreign_key "turmas", "professores", column: "professor_id"
  add_foreign_key "turmas", "semestres"
end
