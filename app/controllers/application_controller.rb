# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user_locale

  protected
  def set_user_locale
    I18n.locale = current_user.locale if user_signed_in?
  end
end
