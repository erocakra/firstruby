class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :full_controller_name

  def full_controller_name
    self.class.name.underscore.gsub('_controller', '').gsub('/', ' ')
  end
end
