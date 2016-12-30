class ContactsController < ApplicationController
  def initialize
    @contact = ""
  end

  def index
    cookies.delete :user_id
    @contacts = Contact.all
  end

  def find
    @contacts = Contact.where(family_name: params[:family_name])
    render 'index.html.erb'
  end

  def sort
    @contacts = Contact.order(:family_name).all
    render "index.html.erb"
  end

  def create
    if !params[:given_name].nil? && !params[:family_name].nil? && !params[:email].nil? && !params[:address].nil?
      if !params[:given_name].blank? && !params[:family_name].blank? && !params[:email].blank? && !params[:address].blank?
        @contact = Contact.new
        @contact.given_name = params[:given_name]
        @contact.family_name = params[:family_name]
        @contact.email = params[:email]
        @contact.address = params[:address]
        if @contact.save
          redirect_to "/contacts"
        else
          redirect_to "/contacts/create"
        end
      else
        flash.now[:alert] = "All fields are required."
      end
    else
      flash.now[:alert] = "Enter contact information:"
    end
  end

  def update
    if !params[:search_given_name].blank? && !params[:search_family_name].blank?
      @contact = Contact.find_by(given_name: params[:search_given_name], family_name: params[:search_family_name])
      if !@contact.nil?
        cookies[:user_id] = @contact.id
        @given_name = @contact.given_name
        @family_name = @contact.family_name
        @email = @contact.email
        @address = @contact.address
      else
        flash.now[:alert] = "Contact not found. Please retry."
      end
    else
      flash.now[:alert] = "Search for contact:"
    end

    if !cookies[:user_id].nil?
      if !params[:given_name].blank? && !params[:family_name].blank? && !params[:email].blank? && !params[:address].blank?
        @contact = Contact.find(cookies[:user_id])
        @contact.given_name = params[:given_name]
        @contact.family_name = params[:family_name]
        @contact.email = params[:email]
        @contact.address = params[:address]
        if @contact.save
          cookies.delete :user_id
          redirect_to "/contacts"
          flash.now[:alert] = "Contact info saved!"
        else
          redirect_to "/contacts/update"
        end
      #if any of the fields are blank, repopulate with contact's information
      elsif params[:given_name].blank? || params[:family_name].blank? || params[:email].blank? || params[:address].blank?
        @contact = Contact.find(cookies[:user_id])
        @given_name = @contact.given_name
        @family_name = @contact.family_name
        @email = @contact.email
        @address = @contact.address
        flash.now[:alert] = "All fields are required."
      end
    end
  end

  def delete
    if !params[:search_given_name].nil? && !params[:search_family_name].nil?
      @contact = Contact.find_by(given_name: params[:search_given_name], family_name: params[:search_family_name])
      if !@contact.nil?
        cookies[:user_id] = @contact.id
        @given_name = @contact.given_name
        @family_name = @contact.family_name
        @email = @contact.email
        @address = @contact.address
      else
        flash.now[:alert] = "Contact not found. Please retry."
      end #inner if end
    else
      flash.now[:alert] = "Search for contact:"
    end #first if end

    if !cookies[:user_id].nil? && (params[:delete] == "Yes")
      @contact = Contact.find(cookies[:user_id])
      @contact.destroy
      cookies.delete :user_id
      redirect_to "/contacts"
    end
    if !cookies[:user_id].nil? && (params[:delete] == "No")
      cookies.delete :user_id
      redirect_to "/contacts"
    end
  end #delete end

end #controller end
