class ProfileAssosiations < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.belongs_to :author
    end
  end
end
