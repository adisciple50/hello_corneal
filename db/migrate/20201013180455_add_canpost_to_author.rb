class AddCanpostToAuthor < ActiveRecord::Migration
    def change
      change_table :authors do |t|
        t.bool :can_post
      end
    end
end
