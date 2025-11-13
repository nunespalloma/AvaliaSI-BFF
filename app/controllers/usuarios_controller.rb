class UsuariosController < ApplicationController
  # POST /usuarios
  def create
    usuario = Usuario.new(usuario_params)

    if usuario.save
        render json: { message: "Usuario criado com sucesso", usuario: usuario }, status: :created
    else
        render json: { errors: usuario.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def usuario_params
    # params do usuário que virão no corpo da requisição
    params.require(:usuario).permit(:nome, :email, :is_coordenacao, :password, :password_confirmation)
  end
end
