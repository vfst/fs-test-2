class RegistrationsController < Devise::RegistrationsController
  def update
    if params[:user][:password].blank?
      params[:user].delete('password')
      params[:user].delete('password_confirmation')
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      sign_in @user, bypass: true
      redirect_to edit_user_registration_url, notice: t('user.updated')
    else
      render 'edit'
    end
  end
end
