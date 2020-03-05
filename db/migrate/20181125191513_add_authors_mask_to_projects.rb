class AddAuthorsMaskToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :authors_mask, :integer, default: nil
  end
end
