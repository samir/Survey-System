class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.references :user
      t.references :survey
      t.timestamps
    end
  end
end
