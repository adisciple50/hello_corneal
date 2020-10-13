class FacebookAssosiations < ActiveRecord::Migration
    def change
      change_table :facebooks do |t|
        t.belongs_to :author
      end
    end
end
