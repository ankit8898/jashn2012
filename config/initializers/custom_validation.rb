 
class JashnFunkyMessageValidator < ActiveModel::Validator
  def validate(record)
    if record.name.blank? && record.sex.blank? && record.cell_num.blank?
      record.errors[:base] << "We cannot move ahead without your Name, Sex and Mobile No."
     elsif record.name.blank?
      record.errors[:base] << "We Need your Name ."
     elsif record.sex.blank?
      record.errors[:base] << "How can you forget your Sex !!!"
     elsif Guest.pluck(:cell_num).include?(record.cell_num)
      record.errors[:base] << "We already have a entry in our Guest list with the number #{record.cell_num} ."	   
     else
      num = record.cell_num.gsub(/\D/, '')	
      record.errors[:base] << "Hmmm... We need your Proper 10 Digit Cell Number.  That's it!" unless num.length.eql?(10) 
  end
  end
end 