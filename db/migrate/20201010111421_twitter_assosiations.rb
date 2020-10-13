class TwitterAssosiations < ActiveRecord::Migration
  def change
    change_table :twitters do |t|
      t.belongs_to :author
    end
  end
end
