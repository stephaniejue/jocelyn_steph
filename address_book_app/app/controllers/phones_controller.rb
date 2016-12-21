class PhonesController < ApplicationController
  def index
    cookies.delete :user_id
    @phones = Phone.all
  end

  def create
    if !params[:search_family_name].nil?
      @contact = Contact.find_by_family_name(params[:search_family_name])
      if !@contact.nil?
        cookies[:user_id] = @contact.id
        @given_name = @contact.given_name
        @family_name = @contact.family_name
      end
    end

    if !params[:number].blank? && !params[:description].blank?
      @phone = Phone.new
      @phone.number = params[:number]
      @phone.description = params[:description]

      @contact = Contact.find(cookies[:user_id])
      @contact.phones << @phone
      if @phone.save
        cookies.delete :user_id
        redirect_to "/contacts"
      else
        redirect_to "/contacts/create"
      end
    end


  end

  def update
  end

  def delete
  end
end
