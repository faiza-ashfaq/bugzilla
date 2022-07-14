# frozen_string_literal: true

class CreateJoinTableUserProject < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :projects do |t|
      t.index %i[user_id project_id]
    end
  end
end
