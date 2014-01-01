class RequestsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validate_account

	def index
		@requests = Request.paginate(page: params[:page], per_page: 10)
	end

	def show
		@request = Request.find(params[:id])
	end

	def edit
		@request = Request.find(params[:id])
	end

	def new
		@request = Request.new
	end

	def create
		request = Request.new(params[:request])
		request.user_id = current_user.id
		request.status = :created
    if request.save
    	RequestMailer.create_request(request).deliver
      redirect_to(requests_path, notice: "New request is successfully created.")
    else
      redirect_to(requests_path, notice: "Failed to create new request.")
    end
	end

	def destroy
		request = Request.find(params[:id])
		if request.destroy
			redirect_to(requests_path, notice: "The Request is deleted successfully")
		else
			redirect_to(requests_path, notice: "Failed to delete the request")
		end
	end

	def update
		@request = Request.find(params[:id])
		check_status
		
		if @request.update_attributes(params[:request])
			process_status
			redirect_to(requests_path, notice: "Your request is updated successfully")
		else
			redirect_to(requests_path, notice: "Failed to update the request")
		end
	end

	private

	def check_status
    @status_changed = true if @request.status != params[:request][:status]
  end

  def process_status
    return if @status_changed == false
    if @request.status == "denied"
      RequestMailer.deny_request(@request)
    elsif @request.status == "cancelled"
      RequestMailer.cancel_user(@request)
    end
  end

  def validate_account
    if current_user.customer_id.nil?
    	flash[:error] = "Your account must be validated."
    end
  end
end