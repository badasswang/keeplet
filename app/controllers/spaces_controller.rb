class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @spaces = current_user.spaces
  end

  def show
    @photos = @space.photos
  end

  def new
    @space = current_user.spaces.build
  end

  def create
    @space = current_user.spaces.build(space_params)

    if @space.save

      if params[:images]
        params[:images].each do |image|
          @space.photos.create(image: image)
        end
      end

      @photos = @space.photos
      redirect_to edit_space_path(@space), notice: "Saved."
    else
      flash[:alert] = "Please provide all information for this room."
      render :new
    end
  end

  def edit 
    if current_user.id == @space.user.id
      @photos = @space.photos
    else
      redirect_to login_path, notice: "Please log in to continue."
    end
  end

  def update
    if @space.update(space_params)

      if params[:images]
        params[:images].each do |image|
          @space.photos.create(image: image)
        end
      end
      redirect_to edit_space_path(@space), notice: "Updated."
    else
      render :edit
    end  
  end

  private

    def set_space
      @space = Space.find(params[:id])
    end

    def space_params
      params.require(:space).permit(:space_type, :space_size, :has_moving, :list_name, :desc, 
                                    :address, :city, :state, :for_car, :price, :active)
    end
end
