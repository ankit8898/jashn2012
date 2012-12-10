class GuestMailer < ActionMailer::Base

  	def send_to_attending(guest)
  		@guest = guest
    	mail(:from => "organizers@jashn-2012.com",
    		 :to => guest.email_id,
        	 :subject => "Jashn 2012: You are Invited !")
  	end

  	 	def send_to_not_attending(guest)
  		@guest = guest
    	mail(:from => "organizers@jashn-2012.com",
    		 :to => guest.email_id,
        	 :subject => "Jashn 2012: We Will Miss your Presence  ")
  	end
end	