class AddContractEndDateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :contract_end_date, :string
  end
end
