# frozen_string_literal: true

class AddReporterAndAssigneeToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :reporter, foreign_key: true
    add_reference :bugs, :assignee, foreign_key: true
  end
end
