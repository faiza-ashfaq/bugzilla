
class ProjectValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add("Creator is not a manager!") unless User.find(record.user_id).manager?
  end
end
