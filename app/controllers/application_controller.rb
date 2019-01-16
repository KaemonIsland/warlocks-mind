class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include IndexView
  include CurrentUserConcern
end
