class CreateTwitters < ActiveRecord::Migration
  def change
    create_table :twitters do |t|
      t.string :profile_image

      t.timestamps null: false
    end
  end
end
