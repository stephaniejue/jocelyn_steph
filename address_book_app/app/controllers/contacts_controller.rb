class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def create
    @contact = Contact.new
    @contact.given_name = params[:given_name]
    @contact.family_name = params[:family_name]
    @contact.email = params[:email]
    @contact.address = params[:address]
    if @contact.save
      redirect_to "/contacts"
    else
      redirect_to "/user"
    end
  end

  def update
  end

  def destroy
  end
end
