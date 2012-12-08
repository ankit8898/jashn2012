module GuestsHelper
	
	def formatted_message arr
		str = 'Sorry! Your '
		a = Array.new
		arr.each do |msg|
		  a <<  msg.split(' ')[0]
		end
		(str + a.join(', ') + ' is Missing ').html_safe
	end

	def get_attendees
      Guest.assign_name_and_avatar
	end

	def formatted_name name
		name + " is Attending "
	end

	def attending_guests guests
		guests.collect {|guest| guest.name if guest.attending}\
	end
end
