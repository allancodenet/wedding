class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  # GET /providers or /providers.json
  def index
    @locations = Provider.distinct.pluck(:location)
    @services = Provider.services.keys
    @q = Provider.ransack(params[:q])
    @providers = @q.result.with_attached_images.order(created_at: :desc).includes(:likes, :ratings)

    if params[:service].present?
      @providers = @providers.where(service: params[:service])
      flash.now[:success] = "Showing #{params[:service]}s."
    end
  end

  # GET /providers/1 or /providers/1.json
  def show
    @provider = Provider.find params[:id]
    @providers = Provider.limit(3)
  end

  # GET /providers/new
  def new
    @provider = Provider.new
    authorize @provider
  end

  # GET /providers/1/edit
  def edit
    console
    @provider = Provider.find params[:id]
    authorize @provider
  end

  # POST /providers or /providers.json
  def create
    @provider = current_user.providers.new(provider_params)
    authorize @provider
    respond_to do |format|
      if @provider.save
        format.html { redirect_to provider_url(@provider), success: "Provider was successfully created." }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1 or /providers/1.json
  def update
    @provider = Provider.find params[:id]
    authorize @provider

    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to provider_url(@provider), success: "Provider was successfully updated." }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
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
      format.json { head :no_content }
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
    current_user.role == provider
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
