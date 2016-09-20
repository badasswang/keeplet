class BookingsController < ApplicationController
	before_action :authenticate_user!

	def preload
		space = Space.find(params[:space_id])
		today = Date.today
		bookings = space.bookings.where("start_date >= ? OR end_date >= ?", today, today)

		render json: bookings
	end

	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		space = Space.find(params[:space_id])
		if current_user.id == space.user.id
			redirect_to space, notice: "You are not permitted to book your own space."
		else
			@booking = current_user.bookings.create(booking_params)
			redirect_to @booking.space, notice: "Booking successful!"
		end
	end

	def your_storages
		@storages = current_user.bookings
	end

	def your_bookings
		@spaces = current_user.spaces
	end

	private

		def booking_params
			params.require(:booking).permit(:start_date, :end_date, :price, :tot_price, :space_id)
		end

		def is_conflict(start_date, end_date)
			space = Space.find(params[:space_id])

			check = space.bookings.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end

end