class RegistrationsController < Devise::RegistrationsController
  def update
    if params[:user][:password].blank?
      params[:user].delete('password')
      params[:user].delete('password_confirmation')
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      sign_in @user, bypass: true
      redirect_to root_path
    else
      render 'edit'
    end
  end
end
