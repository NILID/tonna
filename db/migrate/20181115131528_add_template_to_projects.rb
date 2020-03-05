class AddTemplateToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :template, :string
  end
end
