class HomeController < ApplicationController
  def index
    @locations = Provider.all.map { |provider| provider.location }
    @services = Provider.services.keys
    @q = Provider.ransack(params[:q])
    @providers = @q.result.with_attached_images.order(created_at: :desc)
  end
end
