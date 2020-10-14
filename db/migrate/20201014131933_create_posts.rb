class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.has_many :comment
      t.string :article

      t.timestamps null: false
    end
  end
end