class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    Restaurant.create({name: 'McDonalds', address: '1 City Road, London'})
    redirect_to '/restaurants'
  end

end
