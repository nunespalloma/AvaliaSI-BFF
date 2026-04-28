class PasswordsController < ApplicationController
  def forgot
    usuario = Usuario.find_by(email: params[:email])

    unless usuario
      return render json: {
        error: 'Usuário não encontrado'
      }, status: :not_found
    end

    token = SecureRandom.hex(20)

    usuario.update!(
      reset_password_token: token,
      reset_password_sent_at: Time.current
    )

    render json: {
      message: 'Token gerado com sucesso',
      token: token
    }, status: :ok
  end

  def reset
    usuario = Usuario.find_by(
      reset_password_token: params[:token]
    )

    unless usuario
      return render json: {
        error: 'Token inválido'
      }, status: :unprocessable_entity
    end

    if usuario.reset_password_sent_at < 30.minutes.ago
      return render json: {
        error: 'Token expirado'
      }, status: :unprocessable_entity
    end

    unless params[:password] == params[:password_confirmation]
      return render json: {
        error: 'As senhas não conferem'
      }, status: :unprocessable_entity
    end

    if usuario.update(
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      reset_password_token: nil,
      reset_password_sent_at: nil
    )
      render json: {
        message: 'Senha alterada com sucesso'
      }, status: :ok
    else
      render json: {
        error: usuario.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end