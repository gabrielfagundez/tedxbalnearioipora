class ClientsController < ApplicationController

  before_filter :set_client

  def show
  end

  def edit
  end

  def update
    @client.update_attributes(client_params)
    redirect_to client_path(@client)
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:description)
  end

end
