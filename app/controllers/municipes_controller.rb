class MunicipesController < ApplicationController
  include ApplicationHelper
  before_action :set_municipe, only: %i[ show edit update]
  respond_to :json, :html
  # GET /municipes or /municipes.json

  def index

    search =''
    params_index = params.permit!
    params_to_search = params_index[:q] || {}

    to_search ={
      created_at_gteq:(Date.today - 30.days).beginning_of_day,
      created_at_lteq: Date.today.end_of_day
    }
    @rows = params_index['rows'].presence || 10
    @q = model_name.ransack(to_search)

    @items = @q.result(distinct: true).order(id: :desc)
    @items = @items.page(params[:page]).per(@rows)






  end

  # GET /municipes/1 or /municipes/1.json
  def show
  end

  # GET /municipes/new
  def new
    @municipe = Municipe.new
    @municipe.build_endereco
  end

  # GET /municipes/1/edit
  def edit
  end

  # POST /municipes or /municipes.json
  def create

    @municipe = Municipe.new

    @municipe.nome_completo = municipe_params[:nome_completo]
    @municipe.cpf = municipe_params[:cpf]
    @municipe.cns = municipe_params[:cns]
    @municipe.email = municipe_params[:email]
    @municipe.data_nascimento = municipe_params[:data_nascimento]
    @municipe.telefone = municipe_params[:telefone]
    @municipe.foto = municipe_params[:foto]
    @municipe.status = municipe_params[:status]
    @municipe.municipio_id = municipe_params[:municipio_id]

    respond_to do |format|
      if @municipe.save!(validate: false)

        @endereco = Endereco.new
        @endereco.municipe_id = @municipe.id
        @endereco.cep = endereco_params[:cep]
        @endereco.logradouro = endereco_params[:logradouro]
        @endereco.complemento = endereco_params[:complemento]
        @endereco.bairro = endereco_params[:bairro]
        @endereco.cidade = endereco_params[:cidade]
        @endereco.uf = endereco_params[:uf]
        @endereco.codigo_ibge = endereco_params[:codigo_ibge]
        @endereco.save

        # Envio de e-mail
        NotificationMailer.send_link(@municipe.email, @municipe.nome_completo, "Cadastro").deliver_now
        notification_sms = NotificationSms.new
        notification_sms.send_sms(@municipe.nome_completo, @municipe.telefone)

        format.html { redirect_to municipes_url(@municipe), notice: "Municipe criado com sucesso." }
        format.json { render :show, status: :created, location: @municipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1 or /municipes/1.json
  def update
    @municipe.nome_completo = municipe_params[:nome_completo]
    @municipe.cpf = municipe_params[:cpf]
    @municipe.cns = municipe_params[:cns]
    @municipe.email = municipe_params[:email]
    @municipe.data_nascimento = municipe_params[:data_nascimento]
    @municipe.telefone = municipe_params[:telefone]
    @municipe.foto = municipe_params[:foto]
    @municipe.status = municipe_params[:status]

    respond_to do |format|
      if @municipe.update

        @endereco = Endereco.new
        @endereco.municipe_id = @municipe.id
        @endereco.cep = endereco_params[:cep]
        @endereco.logradouro = endereco_params[:logradouro]
        @endereco.complemento = endereco_params[:complemento]
        @endereco.bairro = endereco_params[:bairro]
        @endereco.cidade = endereco_params[:cidade]
        @endereco.uf = endereco_params[:uf]
        @endereco.codigo_ibge = endereco_params[:codigo_ibge]
        @endereco.save

          # Envio de e-mail
          NotificationMailer.send_link(@municipe.email, @municipe.nome_completo, "Cadastro").deliver_now
          notification_sms = NotificationSms.new
          notification_sms.send_sms(@municipe.nome_completo, @municipe.telefone)


        format.html { redirect_to municipes_url(@municipe), notice: "Municipe was successfully updated." }
        format.json { render :show, status: :ok, location: @municipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @municipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /municipes/1 or /municipes/1.json
  def destroy
    @municipe.destroy

    respond_to do |format|
      format.html { redirect_to municipes_url, notice: "Municipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def model_name
      Municipe
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_municipe
      @municipe = Municipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def municipe_params
      params.permit(:nome_completo, :cpf, :cns, :email, :data_nascimento, :telefone, :foto,:municipio_id, :status)
    end
    def endereco_params
      params.permit(:cep, :logradouro, :complemento, :bairro, :cidade, :uf, :codigo_ibge)

    end
end
