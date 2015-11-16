class ContactSharesController < ApplicationController

  def create
    contact_share = ContactShare.new(contact_share_params)
    if contact_share.save
      render json: contact_share
    else
      render(
        json: contact_share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    destroyed_contact_share = ContactShare.destroy(params[:id])
    render json: destroyed_contact_share
  end

  private

  def contact_share_params
    params.require(:contact_share).permit(:user_id, :contact_id)
  end

  # def update
  #   updated_contact_share = ContactShare.update(params[:id], contact_share_params)
  #   if updated_contact_share
  #     render json: updated_contact_share
  #   else
  #     render(
  #       json: updated_contact_share.errors.full_messages,
  #       status: :unprocessable_entity
  #     )
  #   end
  # end
  #
  # def index
  #   render json: ContactShare.all
  # end
  #
  # def show
  #   render json: ContactShare.find(params[:id])
  # end

end
