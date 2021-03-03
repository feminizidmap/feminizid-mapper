module ResponseHelper
  def response_json
    JSON.parse(response.body)
  rescue StandardError
    {}
  end
end
