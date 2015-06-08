class PhotosController < ApplicationController

	def index
		check_for_new_photos
		@photos = Photo.all
	end

	def show
		@photo = Photo.find(params[:id])
	end

	def check_for_new_photos
		#Get all of my photos from 500px and turn them to a big hash
		@response = F00px.get('photos?feature=user&username=sdleitch&sort=created_at&image_size[]=3&image_size[]=1600&include_store=store_download&include_states=voted')
		@response = JSON.parse(@response.body)
		@to_create = []
		@response['photos'].each do |photo|
			#If this photo doesn't already exist, and wasn't taken on the same date as any that already exists or are set to exist...
			if !photo['id'].in?(Photo.all.pluck(:px_id)) && !photo['taken_at'].to_date.in?(@to_create.map(&:taken_on) || Photo.all.pluck(:taken_on))
				# ...then add it to the photos set to exist.
				@to_create << Photo.new(px_id: photo['id'], title: photo['name'], image_url: photo['image_url'][0], lrg_image_url: photo['image_url'][1], taken_on: photo['taken_at'])
			end
		end
		@to_create.each do |photo|
			photo.save
		end
	end
end
