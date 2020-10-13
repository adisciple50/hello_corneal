class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :profile_image
      t.string :bio

      t.timestamps null: false
    end
  end
end
