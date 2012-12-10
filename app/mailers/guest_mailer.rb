class GuestMailer < ActionMailer::Base

  	def send_mail(guest)
  		@guest = guest
    	mail(:from => "organizers@jashn-2012.com",
    		 :to => guest.email_id,
        	 :subject => "Jashn 2012: You are Invited ")
  	end
end	