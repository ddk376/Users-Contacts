class ContactsController < ApplicationController

  def index
    # SELECT
    #   contacts.*
    # FROM
    #   contacts
    # JOIN
    #   contact_shares ON contact_shares.contact_id = contacts.id
    # JOIN
    #   users ON users.id = contact_shares.user_id
    # WHERE
    #   "contact_shares.user_id = ? OR contacts.user_id = ?"

    contact = Contact
      .select("DISTINCT contacts.*")
      .joins("JOIN contact_shares ON contact_shares.contact_id = contacts.id
             JOIN users ON users.id = contact_shares.user_id")
      .where("contact_shares.user_id = ? OR contacts.user_id = ?", params[:user_id], params[:user_id])

    render json: contact
  end

  def favorite
    contact = Contact
      .select("DISTINCT contacts.*")
      .joins("JOIN contact_shares ON contact_shares.contact_id = contacts.id
             JOIN users ON users.id = contact_shares.user_id")
      .where("contact_shares.user_id = ? OR contacts.user_id = ? &&
      (contacts.favorite == true || contact_shares.favorite == true)", params[:user_id], params[:user_id])

  end

  def show
    render json: Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    updated_contact = Contact.find(params[:id])
    if updated_contact.update_attributes(contact_params)
      render json: updated_contact
    else
      render(
        json: updated_contact.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def destroy
    destroyed_contact = Contact.destroy(params[:id])
    render json: destroyed_contact
  end

  private

  def contact_params
    params.require(:contact).permit(:user_id, :name, :email)
  end
end
