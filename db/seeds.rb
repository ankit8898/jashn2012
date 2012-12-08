# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

attendees = {male: ['Ankit Gupta','Ashish Upadhyae', 'Manohar'], female: ['Ekta Verma', 'Sneha Sharma', 'Yashasree']}

attendees.each_pair do |key,value|
	value.each do |name|
      Guest.create! ({name: name,
                      sex: key,
                      attending: true})
    end  
end