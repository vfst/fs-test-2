require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:user)
    sign_in @user
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get edit" do
    get :edit

    assert_response :success
  end

  test "should update current user profile without password" do
    put :update, user: { name: 'Pirate' }

    assert_redirected_to edit_user_registration_url
    assert_equal 'Pirate', @user.reload.name
  end

  test "should change I18n.locale to @user.locale" do
    assert_equal :en, I18n.locale

    put :update, user: {locale: :ru}

    assert_equal :ru, I18n.locale
  end
end