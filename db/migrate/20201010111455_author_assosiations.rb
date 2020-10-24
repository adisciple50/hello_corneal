class AuthorAssosiations < ActiveRecord::Migration
  def change
    change_table :authors do |t|
      t.references :facebooks
      t.references :twitters
      t.references :profiles
    end
  end
end
