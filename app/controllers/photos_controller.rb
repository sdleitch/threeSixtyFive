class PhotosController < ApplicationController

	def index
		@photos = Photo.all
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

	def show
		@photos = Photo.all
		@photo = Photo.find_by(params[:id])
	end

	def photo_params
		params.require(:photo).permit(:title, :taken_on, :number)
	end
end
