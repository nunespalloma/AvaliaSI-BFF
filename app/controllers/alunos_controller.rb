class AlunosController < ApplicationController
  # POST /alunos
  def create
    usuario = Usuario.new(usuario_params)

    if usuario.save
      aluno = Aluno.new(aluno_params.merge(usuario_id: usuario.id))

      if aluno.save
        render json: { message: "Aluno criado com sucesso", aluno: aluno, usuario: usuario }, status: :created
      else
        usuario.destroy  # rollback manual
        render json: { errors: aluno.errors.full_messages }, status: :unprocessable_entity
      end

    else
      render json: { errors: usuario.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def usuario_params
    # params do usuário que virão no corpo da requisição
    params.require(:usuario).permit(:nome, :email, :password, :password_confirmation)
  end

  def aluno_params
    # params do aluno
    params.require(:aluno).permit(:matricula)
  end
end
