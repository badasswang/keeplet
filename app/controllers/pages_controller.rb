class PagesController < ApplicationController
  def home
  	@spaces = Space.all
  end
end
