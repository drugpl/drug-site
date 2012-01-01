class ContactsController < ApplicationController
  def show
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      redirect_to contact_path, notice: I18n.t('contacts.message_sent_successfuly')
    else
      flash.now[:alert] = I18n.t("contacts.message_not_sent_due_to_errors")
      render :show
    end
  end
end
