class PhotosController < ApplicationController

	def index
		@photos = Photo.all

		#Get all of my photos from 500px and turn them to a big hash
		@response = F00px.get('photos?feature=user&username=sdleitch&sort=created_at&image_size[]=3&image_size[]=1600&include_store=store_download&include_states=voted')
		@response = JSON.parse(@response.body)
		@to_create = []
		@response['photos'].each do |photo|
			if !photo['id'].in?(@photos.pluck(:px_id)) && !photo['taken_at'].to_date.in?(@to_create.map(&:taken_on) || Photo.all.pluck(:taken_on))
				@to_create << Photo.new(px_id: photo['id'], title: photo['name'], image_url: photo['image_url'][0], lrg_image_url: photo['image_url'][1], taken_on: photo['taken_at'])
			end
			# raise 'hell'
		end
		# raise 'hell'
		@to_create.each do |photo|
			photo.save
		end
	end

	def show
		@photo = Photo.find(params[:id])
	end

	# def photo_params
	# 	params.require(:photo).permit(:title, :taken_on, :number, :image_url, :lrg_image_url)
	# end
end
