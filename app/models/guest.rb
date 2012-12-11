class Guest < ActiveRecord::Base
	attr_accessible :attending, :cell_num, :name ,:sex ,:email_id
	validates_with JashnFunkyMessageValidator
	validates :email_id, presence: true
	validates :email_id , format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "is inValid"}
	scope :attending , -> {where(attending: true)}
	class << self
		def assign_name_and_avatar size 
			change_dir_for_avatars size
			data =  attending
 			male_avatars, female_avatars = Dir.glob('m_*.jpg'), Dir.glob('f_*.jpg')
			get_male_female_avatars male_avatars , female_avatars ,data
		end

		def get_male_female_avatars male_avatars , female_avatars , data
			hsh =  HashWithIndifferentAccess.new
			md = male_avatar_details ({male_avatars: male_avatars ,
											   hash: hsh ,
				    					   	   data: data} )

			fd =  female_avatar_details ({female_avatars: female_avatars ,
													hash: hsh ,
												    data: data})
			md + fd
		end

		def list
			assign_name_and_avatar('resized').each_slice(4).to_a
		end

		def male_avatar_details opts = {}
			hsh = opts[:hash]
			hsh[:male]  = Array.new   
			male_data = opts[:data].select {|data| data.sex == 'male'}
			male_data.each {|dt| hsh[:male]<< [dt.name,opts[:male_avatars].sample]}
			hsh[:male]
		end
        
        def female_avatar_details opts = {}
			hsh = opts[:hash]
			hsh[:female]  = Array.new  
			female_data = opts[:data].select {|data| data.sex == 'female'}
			female_data.each {|dt| hsh[:female] << [dt.name,opts[:female_avatars].sample]}
			hsh[:female]
		end

		def change_dir_for_avatars size
			begin
				case size
				when 'original'
					Dir.chdir('app/assets/images')
				when 'resized' 
					Dir.chdir('app/assets/images/resized')	
				end 	
			rescue
				Dir
			end
		end

		

	end
end

