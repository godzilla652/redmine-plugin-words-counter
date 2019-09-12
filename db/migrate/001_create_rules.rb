class CreateRules < ActiveRecord::Migration[5.2]
    def change
      create_table :words do |t|
        t.string :name
        t.integer :object_id
      end
    end
  end
  