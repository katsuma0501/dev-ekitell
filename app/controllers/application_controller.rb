class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => 'kobayashi', :password => 'kobayashi' if Rails.env == "production"
  protect_from_forgery with: :exception
end
