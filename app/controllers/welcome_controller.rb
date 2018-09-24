class WelcomeController < ApplicationController
  def index
    render json: { code: :ok }
  end
end
