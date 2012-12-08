class Guest < ActiveRecord::Base
	attr_accessible :attending, :cell_num, :name ,:sex
	validates :name , presence: true
	validates :sex , presence: true
end
