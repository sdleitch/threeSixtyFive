class PhotosController < ApplicationController

	def index
		@photos = Photo.all

		#Get all of my photos from 500px and turn them to a big hash
		@response = F00px.get('photos?feature=user&username=sdleitch&sort=created_at&image_size=3&include_store=store_download&include_states=voted')
		@response = JSON.parse(@response.body)
		@to_create = []
		@response['photos'].each do |photo|
			if !photo['id'].in?(Photo.all.pluck(:px_id))
				@to_create << Photo.new(px_id: photo['id'], title: photo['name'], image_url: photo['image_url'])
			end
			# raise 'hell'
		end
		@to_create.each do |photo|
			photo.save
		end
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
