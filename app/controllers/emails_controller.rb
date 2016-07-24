class EmailsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_email, only: [:show, :destroy]

    def index
      @emails = current_user.emails.order("created_at DESC")
    end

    def show
    end

    def new
      @email = Email.new
      @users = User.all
    end

    def create

      @emails = User.pluck(:email)
      @email = current_user.emails.new(params[:email].permit(:subject, :body))

      if @email.save
        EmailWorker.perform_async(@emails, @email.subject, @email.body)
        @email.update(to: @emails)
        redirect_to user_emails_path(current_user), notice: "Email successfully sent."
      else
        render 'new'
      end

    end


    def destroy
      if @email.destroy
        redirect_to user_emails_path(current_user)
      else
        render 'show'
      end
    end

    private

    def find_email
      @email = Email.find(params[:id])
    end

end
