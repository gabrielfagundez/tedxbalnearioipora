class ClientsController < ApplicationController

  def index
    if current_user.admin?
      @clients = current_account.clients
    else
      @clients = current_user.clients
    end
  end

end
