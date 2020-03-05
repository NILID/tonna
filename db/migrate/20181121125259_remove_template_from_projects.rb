class RemoveTemplateFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :template
  end
end
