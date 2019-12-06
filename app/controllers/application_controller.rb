class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include RequirePermission
  include CurrentUserConcern
end
