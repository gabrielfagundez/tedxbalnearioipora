class Api::WidgetsController < Api::ApiController

  def destroy
    Widget.find(params[:id]).delete
    render json: {}.to_json
  end

end
