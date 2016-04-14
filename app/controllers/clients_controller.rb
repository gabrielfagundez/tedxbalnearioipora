class ClientsController < ApplicationController

  def index
    @clients = current_user.clients
  end

end
