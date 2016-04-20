class AddAccountIdToCLient < ActiveRecord::Migration
  def change
    add_column :clients, :account_id, :integer
  end
end
