class HousesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_account

	respond_to :json, only: [:create, :update]

  def index
    @houses = House.paginate(page: params[:page], per_page: 10)
  end

  def create
    @house = House.new(params[:house])
    if @house.save
      respond_with(@house, :status => 200, :default_template => :show)
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  def update
    @house = House.find(params[:id])

    if @house.update_attributes(params[:house])
      render json: @house, :status => 200, :default_template => :show
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  def new
    @house = House.new
    @house.homeowner_id = params[:homeowner]
  end
  
  def edit
    @house = House.find(params[:id])

  end

  def show
    @house = House.find(params[:id])

  end

  def destroy
    house = House.find(params[:id])
    if house.destroy
      redirect_to(houses_path, notice: "The House is deleted successfully")
    else
      redirect_to(houses_path, notice: "Failed to delete the house")
    end
  end

  private
  def validate_account
    if current_user.has_role? (:admin) == false && current_user.customer_id.nil?
      flash[:error] = "Your account must be validated."
    end
  end
end