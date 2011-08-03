class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :user
      t.string :title,       :limit => 255
      t.string :description, :limit => 511
      t.boolean :is_active,  :default => false 
      t.boolean :is_public,  :default => false

      t.timestamps
    end
  end
end
