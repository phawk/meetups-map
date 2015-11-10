class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def pagination_meta(scope)
    { has_more: !scope.last_page?, total_count: scope.total_count, count: scope.count }
  end
end
