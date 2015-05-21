class PhotoController < ApplicationController

	def index
		@photos = Photos.all
	end

	def new
		@photo = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
		if @photo.save
			redirect_to '/photos'
		else
			redirect_to '/photos', notice: "Something went wrong"
		end
	end

	def photo_params
		params.require(:photo).permit(:title, :taken_on, :number)
	end
end
