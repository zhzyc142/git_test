class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def self.action_methods_with_fullname
    (action_methods.to_a.delete_if{|x| /_callback_before_*/=~x} - ApplicationController.new.action_methods.to_a).map{|name| {subject:self.to_s.gsub!("Controller", "").singularize, action:name}}
  end
  def current_user
    @user  = User.last
  end
end
