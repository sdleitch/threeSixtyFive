class Photo < ActiveRecord::Base
	def next_pic
		Photo.find_by(id: self.id+1).present?
	end  

	def prev_pic
		Photo.find_by(id: self.id-1).present?
	end
end
