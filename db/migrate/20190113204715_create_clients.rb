class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :title, null: false
      t.text :desc
      t.string :email
      t.string :phone
      t.string :url
      t.string :site
      t.boolean :send_hello, default: false

      t.timestamps
    end
  end
end
