class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question
      t.string :content, :limit => 127
      t.timestamps
    end
  end
end
