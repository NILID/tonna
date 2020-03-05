class AddCategoriesToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :categories, :text, default: nil
  end
end
