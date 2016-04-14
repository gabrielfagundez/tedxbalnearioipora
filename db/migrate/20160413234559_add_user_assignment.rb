class AddUserAssignment < ActiveRecord::Migration
  def change
    create_table :clients_users do |t|
      t.integer :user_id
      t.integer :client_id
    end
  end
end
