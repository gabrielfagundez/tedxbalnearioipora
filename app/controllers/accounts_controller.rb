class AccountsController < ApplicationController

  def show
    @account = current_account
  end

  def update
    current_account.update_attributes(account_params.merge(billable: params[:account][:billable] == 'billable'))
    redirect_to account_path(current_account)
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end

end
