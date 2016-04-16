class AddCodeReviewInfoToProject < ActiveRecord::Migration
  def change
    add_column :projects, :code_review_model, :string
  end
end
