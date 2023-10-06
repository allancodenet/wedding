class LikesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_provider
  before_action :client
  before_action :require_liker!

  def update
    if @provider.liked_by?(client)
      @provider.unlike(client)
    else
      @provider.like(client)
    end

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(dom_id(@provider, :likes), partial: "providers/like", locals: {provider: @provider})
      }
    end
  end

  private

  def set_provider
    @provider = Provider.find params[:provider_id]
  end

  def client
    current_user.client
  end

  def require_liker!
    unless client.present?
      flash[:warning] = "Must be a client to like"
      redirect_to @provider
    end
  end
end
