class SessionsController < ApplicationController
  # POST /login
  def create
    # Busca o usuário pelo email
    usuario = Usuario.find_by(email: params[:email])

    # Autentica a senha com has_secure_password
    if usuario&.authenticate(params[:password])
      # Descobre o "tipo" do usuário
      tipo =
        if usuario.aluno.present?
          'aluno'
        elsif usuario.is_coordenacao?
          'coordenacao'
        else
          'usuario'
        end

      render json: {
        mensagem: 'Login realizado com sucesso',
        usuario: {
          id: usuario.id,
          nome: usuario.nome,
          email: usuario.email,
          tipo: tipo,
          aluno_id: usuario.aluno&.id,
          is_coordenacao: usuario.is_coordenacao
        }
      }, status: :ok
    else
      render json: { erro: 'Email ou senha inválidos' }, status: :unauthorized
    end
  end
end
