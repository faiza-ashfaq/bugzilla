# frozen_string_literal: true

module BugsHelper
  def assign_dev(bug, dev)
    bug.update(assignee_id: dev)
  end

  def resolve(bug)
    bug.update(status: 3)
  end
end
