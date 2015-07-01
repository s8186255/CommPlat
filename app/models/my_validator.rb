class MyValidator  < ActiveModel::Validator
  def validate(record)
    if record.card_type.applicant_type == "vehicle"
      record.vehicle_no.presence
      record.errors[:base] << "This person is evil"
    end
  end
end
