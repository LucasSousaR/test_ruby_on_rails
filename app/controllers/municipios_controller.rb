class MunicipiosController < ApplicationController
  include ApplicationHelper
  before_action :set_municipio, only: %i[ show edit update]
  respond_to :json, :html
  # GET /municipios or /municipios.json
  #
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

  # GET /municipios/1 or /municipios/1.json
  def show
  end

  # GET /municipios/new
  def new
    @municipio = Municipio.new
  end

  # GET /municipios/1/edit
  def edit
  end

  # POST /municipios or /municipios.json
  def create
    @municipio = Municipio.new(municipio_params)

    respond_to do |format|
      if @municipio.save
        format.html { redirect_to municipios_url(@municipio), notice: "Create municipio was successfully created." }
        format.json { render :show, status: :created, location: @municipio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @municipio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipios/1 or /municipios/1.json
  def update
    respond_to do |format|
      if @municipio.update(municipio_params)
        format.html { redirect_to municipios_url(@municipio), notice: "Create municipio was successfully updated." }
        format.json { render :show, status: :ok, location: @municipio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @municipio.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    def model_name
      Municipio
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_municipio
      @municipio = Municipio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def municipio_params
      params.permit(:nome)
    end
end
