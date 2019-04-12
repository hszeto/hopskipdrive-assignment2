module ErrorHandler
  extend ActiveSupport::Concern

  ##################### Usage ######################
  # raise "Some error!"
  # raise ErrorHandler::UnprocessableEntity, "no go"
  ##################################################
  class UnprocessableEntity < StandardError; end

  included do
    rescue_from StandardError do |e|
      response_error(e)
    end
  end

  private

  def response_error(e = nil, code = 422)
    if e.nil?
      obj = {}
    else
      headers['Warning'] = e.message
      obj = { error: e.message }
    end

    render json: obj, status: code
  end
end
