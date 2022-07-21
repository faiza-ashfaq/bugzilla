# frozen_string_literal: true

class BugValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add('Assignee is not a Developer!') unless User.find(record.assignee_id).developer? if record.assignee.present?
    record.errors.add('Reporter is not a QA!') unless User.find(record.reporter_id).qa? if record.reporter.present?
  end
end
