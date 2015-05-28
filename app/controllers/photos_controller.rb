class PhotosController < ApplicationController

	def index
		@photos = Photo.all

		#Get all of my photos from 500px and turn them to a big hash
		@response = F00px.get('photos?feature=user&username=sdleitch&sort=created_at&image_size=3&include_store=store_download&include_states=voted')
		@response = JSON.parse(@response.body)
		@response_photos = []
		@response['photos'].each do |photo|
			@response_photos << photo['id']
		end

		#Check if any of the pictures don't already exist.
		@photos.each do |photo|
			if !photo.px_id.in?(@response_photos)
				raise 'hell'
			end
		end

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
		@photo = Photo.find_by(params[:id])
	end

	def photo_params
		params.require(:photo).permit(:title, :taken_on, :number, :image_url)
	end
end
