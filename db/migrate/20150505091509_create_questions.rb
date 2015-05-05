class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.text :additional_info

      t.integer :user_id

      t.timestamps
    end
  end
end
