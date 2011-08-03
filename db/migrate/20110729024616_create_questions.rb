class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :survey
      t.string :content, :limit => 511

      t.timestamps
    end
  end
end
