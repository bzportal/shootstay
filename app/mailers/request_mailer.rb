class RequestMailer < ActionMailer::Base
  default :from => "\"ShootStay\" <info@shootstay.com>"
  
  def create_request(request)
  	@request = request
  	mail(:from => request.user.email, to: ENV["MANDRILL_USERNAME"], :subject => "New Request")
  end

  def cancel_request(request)
  	@request = request
  	mail(:to => request.user.email, :subject => "Your shootstay has been cancelled.").deliver
  end

  def deny_request(request)
  	@request = request
  	mail(:to => request.user.email, :subject => "We are sorry we can not book your shootstay.").deliver
  end
end
