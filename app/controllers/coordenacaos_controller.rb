class CoordenacaosController < ApplicationController
  # POST /coordenacaos
  def create
    usuario = Usuario.new(usuario_params)

    if usuario.save
      coordenacao = Coordenacao.new(usuario: usuario)

      if coordenacao.save
        render json: {
          message: "Coordenação criada com sucesso",
          coordenacao: coordenacao,
          usuario: usuario
        }, status: :created
      else
        # rollback manual se der erro ao salvar a coordenacao
        usuario.destroy
        render json: { errors: coordenacao.errors.full_messages }, status: :unprocessable_entity
      end

    else
      render json: { errors: usuario.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def usuario_params
    params.require(:usuario).permit(:nome, :email, :password, :password_confirmation)
  end
end
