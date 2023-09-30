class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy all]
  before_action :verify_role, only: %i[all]
  # GET /providers or /providers.json
  def index
    @locations = Provider.published.distinct.pluck(:location)
    @services = Provider.published.services.keys
    @q = Provider.published.ransack(params[:q]&.permit!)
    @pagy, @providers = pagy_countless(@q.result.with_attached_images.includes(:likes, :ratings), items: 5)
  end

  # GET /providers/1 or /providers/1.json
  def show
    if user_signed_in?
      authorize @provider
      @provider = Provider.find params[:id]
    else
      @provider = Provider.published.find params[:id]
    end
  end

  # GET /providers/new
  def new
    @provider = Provider.new
    authorize @provider
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find params[:id]
    authorize @provider
  end

  # POST /providers or /providers.json
  def create
    @provider = current_user.providers.new(provider_params)
    authorize @provider
    respond_to do |format|
      if @provider.save
        format.html { redirect_to all_providers_path, success: "Service draft was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1 or /providers/1.json
  def update
    @provider = Provider.find params[:id]
    authorize @provider

    respond_to do |format|
      if @provider.update(provider_params)
        if @provider.draft?
          format.html { redirect_to all_providers_path, success: "service draft was successfully updated." }
        else
          format.html { redirect_to provider_url(@provider), success: "Provider was successfully updated." }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1 or /providers/1.json
  def destroy
    @provider = Provider.find params[:id]
    authorize @provider
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url, danger: "Provider was successfully destroyed." }
    end
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later
    redirect_back(fallback_location: request.referer, notice: "Image deleted")
  end

  def all
    @providers = current_user.providers
  end

  private

  def verify_role
    unless current_user.role == "provider"
      redirect_to providers_path, danger: "unauthorized."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_provider
    @provider = Provider.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def provider_params
    params.require(:provider).permit(:service, :name, :motto, :description, :website, :instagram, :tiktok, :facebook, :phone_number, :location, images: [])
  end
end
