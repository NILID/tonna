class AddHideFlagToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :hide, :boolean, default: true
  end
end
