class Api::ApplicationController < ActionController::API
  before_action :set_default_format
  before_action :authenticate_user!

  include Authorization

  protected

  def set_default_format
    request.format = :json
  end
end