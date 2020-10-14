class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.has_one :author
      t.belongs_to :post
      t.string :content

      t.timestamps null: false
    end
  end
end
