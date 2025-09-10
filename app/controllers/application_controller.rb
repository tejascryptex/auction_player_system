# class ApplicationController < ActionController::Base
#   # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
#   allow_browser versions: :modern
#   respond_to :html, :json
# end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :force_html_format

  private

  def force_html_format
    request.format = :html if request.format == "*/*" || request.format.nil?
  end
end
