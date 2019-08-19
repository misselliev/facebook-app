class PagesController < ApplicationController
  def home;end

  def aqui
    render json: { status: 'OK' }
  end
end
