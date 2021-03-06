class AccountSessionsController < ApplicationController
  layout false

  def new
    @session = AccountSession.new
  end

  def create
    @session = AccountSession.new params[ :account_session ]
    if @session.save
      session[:autofinger_level] = 1
      account = Account.where(:username => @session.username).first #todo - I bet there's a better way to do this line
      account.login = Time.now
      account.save!
      redirect_to root_path
    else
      render :action => :new
    end
  end

  def destroy
    current_account_session.destroy
    flash[ :notice ] = "You've been logged out."
    redirect_to login_path
  end
  
end
