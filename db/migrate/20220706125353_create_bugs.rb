# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, index: { unique: true }
      t.datetime :deadline
      t.integer :bug_type, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
