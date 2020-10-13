class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :email
      t.string :salt
      t.string :username
      t.integer :profile_image_type

      t.timestamps null: false
    end
  end
end
