class ClientsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  # before_action :set_client!
  # GET /clients/1 or /clients/1.json
  def show
    if current_user.client.present?
      @client = current_user.client
      authorize @client
    else
      redirect_to new_client_path(current_user)
    end
  end

  # GET /clients/new
  def new
    @client = current_user.build_client
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find params[:id]
    authorize @client
  end

  # POST /clients or /clients.json
  def create
    @client = current_user.build_client(client_params)
    authorize @client
    respond_to do |format|
      if @client.save
        format.html { redirect_to client_url(@client), notice: "Your profile was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    @client = Client.find params[:id]
    authorize @client
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to client_url(@client), notice: "Your profile was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json

  private

  # Use callbacks to share common setup or constraints between actions.

  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:name, :event_date, :location, :guest_no, :budget, :phone_number)
  end
end
