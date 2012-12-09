class Guest < ActiveRecord::Base
	attr_accessible :attending, :cell_num, :name ,:sex ,:email_id
	validates_with JashnFunkyMessageValidator
	validates :email_id, presence: true
	validates :email_id , format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "is inValid"}
    scope :attending , -> {where(attending: true)}
	class << self
      def assign_name_and_avatar
		 hsh =  HashWithIndifferentAccess.new
		 begin
		  Dir.chdir('app/assets/images')
		 rescue
		  Dir
		end
		 all_data = limit(12)
	     male_avatars, female_avatars = Dir.glob('m_*.jpg'), Dir.glob('f_*.jpg')
	     md = male_avatar_details ({male_avatars: male_avatars ,
	                           hash: hsh ,
	                           all_data: all_data} )

	     fd =  female_avatar_details ({female_avatars: female_avatars ,
	                           hash: hsh ,
	                           all_data: all_data})
	     
	     md + fd
	 end

	 def male_avatar_details opts = {}
	 	hsh = opts[:hash]
	 	hsh[:male]  = Array.new   
	    male_data = opts[:all_data].select {|data| data.sex == 'male'}
	    male_data.each {|dt| hsh[:male]<< [dt.name,opts[:male_avatars].sample]}
	    hsh[:male]
	 end
     
     def female_avatar_details opts = {}
     	hsh = opts[:hash]
	 	hsh[:female]  = Array.new  
	    female_data = opts[:all_data].select {|data| data.sex == 'female'}
	    female_data.each {|dt| hsh[:female] << [dt.name,opts[:female_avatars].sample]}
	    hsh[:female]
	 end
	
	end
end

