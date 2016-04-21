class AddBillableAttributeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :billable, :boolean, default: true
  end
end
