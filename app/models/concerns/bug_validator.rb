# frozen_string_literal: true

class BugValidator < ActiveModel::Validator
  def validate(record)
    if !User.find(record.assignee_id).developer? && !(User.find(record.reporter_id).qa? &&
      record.errors.add('Assignee is not a Developer!'))
      record.errors.add('Reporter is not a QA!')
    end
  end
end
