class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from Exception, with: :error_response

  private
  def error_response(exception)
    render json: {
      status: :internal_server_error,
      message: "Terjadi kesalahan pada server"
    }, status: :internal_server_error
  end
end
