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
		Guest.assign_name_and_avatar('original')
	end

	def formatted_name name
		['Awesome', 'Woahhh', 'Ahaaaaa..', 'Cool','Beautiful', 'Amazing','Alarming','Beware','Stupendous','Excellent'].sample + '...   ' + name.capitalize + " is Attending "
	end

	def formatted_guest_list name
		str = name.capitalize + "<br> is Attending "
		str.html_safe
	end
	
	def image arr
		arr ? "resized/#{arr[1]}" : 'resized/default_avatar.jpg'
	end

	def formatted_count
		Guest.attending.count.to_s + " Attending"
	end

	def guests_attending 
		Guest.attending.pluck(:name)		
	end
end
