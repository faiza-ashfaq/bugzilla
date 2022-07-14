# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username,   null: false, unique: true
      t.string :email,      null: false, unique: true
      t.string :password,   null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
