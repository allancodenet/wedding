class LikesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_provider
  before_action :client

  def update
    if @provider.liked_by?(client)
      @provider.unlike(client)
    else
      @provider.like(client)
    end

    respond_to do |format|
      render turbo_stream: turbo_stream.replace(dom_id(@provider, :likes), partial: "providers/like", locals: {provider: @provider})
    end
  end

  def set_provider
    @provider = Provider.find params[:provider_id]
  end

  def client
    current_user.client
  end
end
