class HomeController < ApplicationController
  def index
    @services = Provider.services.keys
  end
end
