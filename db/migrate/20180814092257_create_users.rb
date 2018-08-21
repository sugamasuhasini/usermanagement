class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :shell_type
      t.string :home_folder
      t.string :password
      t.boolean :grant_sudo

      t.timestamps
    end
  end
end
