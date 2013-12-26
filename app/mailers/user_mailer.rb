class UserMailer < ActionMailer::Base
  default :from => "\"ShootStay\" <info@shootstay.com>"

  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end

  def decline_user(user)
  	@user = user
  	mail(:to => user.email, :subject => "Your account has been disapproved")
  end

  def approve_user(user)
  	@user = user
  	mail(:to => user.email, :subject => "Your account has been disapproved")
  end

  def user_applied(user)
  	@user = user
  	mail(:from => user.email, to: ENV["MANDRILL_USERNAME"], :subject => "#{user.name} has been applied.")
  end

end