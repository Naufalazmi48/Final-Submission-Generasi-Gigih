class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  rescue_from Exception, with: :error_response

   def validate_params(list_params)
    is_valid = true
    list_params.each do |key|
      is_valid = false unless params.has_key?(key)
    end
    is_valid
  end

  def response_with_message(status, message)
    response = {
      status: status,
      message: message
    }
  end

  def response_with_data(status, data)
    response = {
      status: status,
      data: data
    }
  end

  private

  def error_response(_exception)
    render json: {
      status: :internal_server_error,
      message: 'Terjadi kesalahan pada server'
    }, status: :internal_server_error
  end
end
