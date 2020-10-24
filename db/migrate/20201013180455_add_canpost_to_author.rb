class AddCanpostToAuthor < ActiveRecord::Migration
    def change
      change_table :authors do |t|
        t.boolean :can_post
      end
    end
end
