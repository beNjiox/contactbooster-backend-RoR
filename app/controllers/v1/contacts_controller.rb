module V1
  class ContactsController < ApplicationController
    def index
      @contacts = List.find(params[:list_id]).contacts
      render
    end

    def show
      @contact = List.find(params[:list_id]).contacts.find(params[:id])
      render
    end

    def destroy
      @contact = List.find(params[:list_id]).contacts.find(params[:id])
      @contact.destroy

      head status: :no_content
    end

    def create
      @contact = List.find(params[:list_id]).contacts.create(contact_param)

      if @contact.save
        render @contact, status: :created
      else
        render json: { error: @contact.errors }, status: :bad_request
      end
    end

    def update
      @contact = List.find(params[:list_id]).contacts.find(params[:id])
      if @contact.update(contact_param)
        render @contact
      else
        render json: { error: @contact.errors }, status: :bad_request
      end
    end

    private
    def contact_param
      params.required(:contact).permit(:firstname, :lastname, :phone)
    end
  end
end