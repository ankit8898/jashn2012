class GuestMailer < ActionMailer::Base

  	def send_mail(user_email)
    	mail(:from => "webmasters@Jashn2012.com",
    		 :to => user_email,
        	 :subject => "You have been Invited!")
  	end
end	