class AuthorAssosiations < ActiveRecord::Migration
  def change
    change_table :authors do |t|
      t.has_one :facebooks
      t.has_one :twitters
      t.has_one :profiles
    end
  end
end
