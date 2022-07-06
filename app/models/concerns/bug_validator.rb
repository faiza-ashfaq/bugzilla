
class BugValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add("Not a QA!") unless User.find(record.reporter_id).type == "QA" and record.errors.add("Not a Developer!") unless User.find(record.assignee_id).type == "QA"
  end
end
