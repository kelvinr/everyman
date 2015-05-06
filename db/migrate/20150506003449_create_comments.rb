class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content

      t.belongs_to :commentable, polymorphic: true
      t.integer :user_id

      t.timestamps
    end
  end
end
