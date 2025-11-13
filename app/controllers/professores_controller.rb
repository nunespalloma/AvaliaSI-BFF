class ProfessoresController < ApplicationController
  before_action :set_professor, only: [:show, :update, :destroy]

  # GET /professores
  def index
    professores = Professor.order(:id)
    render json: professores
  end

  # GET /professores/:id
  def show
    render json: @professor
  end

  # POST /professores
  def create
    professor = Professor.new(professor_params)
    if professor.save
      render json: professor, status: :created
    else
      render json: { errors: professor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /professores/:id
  def update
    if @professor.update(professor_params)
      render json: @professor
    else
      render json: { errors: @professor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /professores/:id
  def destroy
    @professor.destroy
    head :no_content
  end

  private

  def set_professor
    @professor = Professor.find(params[:id])
  end

  def professor_params
    params.require(:professor).permit(:nome, :email)
  end
end
