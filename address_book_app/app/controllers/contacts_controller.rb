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
    # if !params[:search_family_name].nil?
    #   @contact = Contact.find_by_family_name(params[:search_family_name])
    #   @given_name = @contact.given_name
    #   @family_name = @contact.family_name
    #   @email = @contact.email
    #   @address = @contact.address
    # else
    #   flash.now[:alert] = "Enter a contact"
    # end
    if !params[:search_family_name].nil?
      @contact = Contact.find_by_family_name(params[:search_family_name])
      if !params[:given_name].nil? || !params[:family_name].nil? || !params[:email].nil? || !params[:address].nil?
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
    end
  end

  def destroy
  end
end
