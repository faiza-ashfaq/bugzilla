
class BugValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add("Reporter is not a QA!") unless User.find(record.reporter_id).qa? and record.errors.add("Assignee is not a Developer!") unless User.find(record.assignee_id).developer?
  end
end
