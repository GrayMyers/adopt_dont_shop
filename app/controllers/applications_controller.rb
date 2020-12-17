class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.new(
      app_params
    )
    application.save

    redirect_to "/applications/#{application.id}"
  end

  def submit
    application = Application.find(params[:id])
    redirect_to "/applications/#{application.id}"
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    if @application.update(description: params[:description])
      @application.submitted = true
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:error] = @application.errors.full_messages
      render :edit
    end
  end

  private

  def app_params
    params.permit(:applicant, :address, :city, :state, :zip)
  end


end
