class ApplicationController < ActionController::API
  def success(status: :ok)
    render_status('success', status)
  end

  def failure(status: :unprocessable_entity, errors: [])
    render_status('failed', status, errors)
  end

  private

  def render_status(readable_status, status, errors = [])
    data = { status: readable_status }
    data[:errors] = errors if errors.any?
    render json: data, status: status
  end
end
