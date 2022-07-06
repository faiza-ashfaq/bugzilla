
class ProjectValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add("Not a manager!") unless User.find(record.user_id).type == "Manager"
  end
end
