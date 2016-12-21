class ContactsController < ApplicationController
  def initialize
    @contact = ""
  end

  def index
    cookies.delete :user_id
    @contacts = Contact.all
  end

  def sort
    @contacts = Contact.order(:family_name).all
    render "index.html.erb"
  end

  def create
    if !params[:given_name].nil? && !params[:given_name].strip.empty? && !params[:family_name].nil? && !params[:family_name].strip.empty? && !params[:email].nil? && !params[:address].nil?
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
    elsif (params[:given_name].nil? || !params[:given_name].strip.empty? || !params[:family_name].nil? || !params[:family_name].strip.empty?)
      flash.now[:alert] = "Contact must have a given name and family name!"
    else
      flash.now[:alert] = "Please fill out contact info."
    end
  end

  def update
    if !params[:search_family_name].nil?
      @contact = Contact.find_by_family_name(params[:search_family_name])
      if !@contact.nil?
        cookies[:user_id] = @contact.id
        @given_name = @contact.given_name
        @family_name = @contact.family_name
        @email = @contact.email
        @address = @contact.address
      end
    end

    if !cookies[:user_id].nil? && !params[:given_name].nil? && !params[:family_name].nil? && !params[:email].nil? && !params[:address].nil? && !params[:given_name].strip.empty? && !params[:family_name].strip.empty?
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
    end
  end

  def delete
    if !params[:search_family_name].nil?
      @contact = Contact.find_by_family_name(params[:search_family_name])
      if !@contact.nil?
        cookies[:user_id] = @contact.id
        @given_name = @contact.given_name
        @family_name = @contact.family_name
        @email = @contact.email
        @address = @contact.address
      end #inner if end
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
