class HomeController < ApplicationController

  include ApplicationHelper
  def index

    params_to_search = params[:q] || {}
    @q =  Municipe.ransack(params_to_search)


    if params_to_search.present?
      @municipe = Municipe.find(params_to_search['id_eq'])
    end



    @items = @q.result(distinct: true)


  #horas_restantes, minutos_restantes = calcular_horas_restantes(horas_str, minutos_a_remover)



  end

end
