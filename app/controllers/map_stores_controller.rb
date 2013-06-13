class MapStoresController < ApplicationController
  def index
  	@stores = Store.all
  end
end
