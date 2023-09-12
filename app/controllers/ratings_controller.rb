class RatingsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :record
  before_action :rater
  before_action :require_rater!

  def new
    console
    if @provider.rated_by?(current_user.client)
      redirect_to @provider
    else
      @rating = Rating.new
    end
  end

  def edit
    @rating = Rating.find params[:id]
  end

  def create
    @rating = Rating.new(rating_params)
    respond_to do |format|
      if @rating.save
        format.html { redirect_to @provider, notice: "Rating was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @rating = Rating.find params[:id]
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @provider, notice: "Rating was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rating = Rating.find params[:id]
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to @provider, danger: "Rating was successfully destroyed." }
    end
  end

  private

  def require_rater!
    unless rater.present?
      flash[:warning] = "Must be a client to rate"
      redirect_to @provider
    end
  end

  def rater
    current_user.client
  end

  def record
    @provider = Provider.find params[:provider_id]
  end

  def rating_params
    params.require(:rating).permit(:star).merge(rater:, record:)
  end
end
