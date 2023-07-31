class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  # GET /providers or /providers.json
  def index
    @providers = Provider.all
  end

  # GET /providers/1 or /providers/1.json
  def show
  end

  # GET /providers/new
  def new
    @provider = Provider.new
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
        format.html { redirect_to provider_url(@provider), notice: "Provider was successfully created." }
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
        format.html { redirect_to provider_url(@provider), notice: "Provider was successfully updated." }
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
      format.html { redirect_to providers_url, notice: "Provider was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provider_params
      params.require(:provider).permit(:service, :name, :description, :website, :instagram, :tiktok, :location, images:[])
    end
end
