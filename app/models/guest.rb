class Guest < ActiveRecord::Base
  attr_accessible :attending, :cell_num, :name
  validates :name , presence: true
end
