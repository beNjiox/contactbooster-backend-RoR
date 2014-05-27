class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :fake_load

  private
  def fake_load
    # sleep 2
  end
  def record_not_found
    render json: {error: 'resource not found.'}, status: 404
  end
end
