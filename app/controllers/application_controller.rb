class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
  before_action :null_blank_id_params
  def null_blank_id_params
    # without this, a random record is returned.
    params[:id] = nil if params[:id].blank?
  end
end
