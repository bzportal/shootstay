class HomeownersController < ApplicationController
  before_filter :authenticate_user!

	def index
		@homeowners = Homeowner.paginate(page: params[:page], per_page: 10)
	end

	def show
		@homeowner = Homeowner.find(params[:id])
		@houses = @homeowner.houses.paginate(page: params[:page], per_page: 10)
	end

	def edit
		@homeowner = Homeowner.find(params[:id])
	end

	def new
		@homeowner = Homeowner.new
	end

	def create
		homeowner = Homeowner.new(params[:homeowner])

    if homeowner.save
      redirect_to(homeowners_path, notice: "New homeowner is successfully created.")
    else
      redirect_to(homeowners_path, notice: "Failed to create new homeowner.")
    end
	end

	def destroy
		homeowner = Homeowner.find(params[:id])
		if homeowner.destroy
			redirect_to(homeowners_path, notice: "The Homeowner is deleted successfully")
		else
			redirect_to(homeowners_path, notice: "Failed to delete the homeowner")
		end
	end

	def update
		@homeowner = Homeowner.find(params[:id])
		
		if @homeowner.update_attributes(params[:homeowner])
			redirect_to(homeowners_path, notice: "Your homeowner is updated successfully")
		else
			redirect_to(homeowners_path, notice: "Failed to update the homeowner")
		end
	end

	private

	def check_status
    @status_changed = true if @homeowner.status != params[:homeowner][:status]
  end

  def process_status
    return if @status_changed == false
    if @homeowner.status == "denied"
      HomeownerMailer.deny_homeowner(@homeowner)
    elsif @homeowner.status == "cancelled"
      HomeownerMailer.cancel_user(@homeowner)
    end
  end
end
