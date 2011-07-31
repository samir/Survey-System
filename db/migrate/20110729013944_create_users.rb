class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :limit => 127
      t.string :email, :limit => 127
      t.string :avatar
      t.string :password_digest
      t.string :auth_token

      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :password_digest, :unique => true
  end
end
