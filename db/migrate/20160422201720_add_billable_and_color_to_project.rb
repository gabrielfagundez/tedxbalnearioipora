class AddBillableAndColorToProject < ActiveRecord::Migration
  def change
    add_column :projects, :billable, :boolean
    add_column :projects, :color, :string
  end
end
