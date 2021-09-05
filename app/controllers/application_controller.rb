class ApplicationController < ActionController::Base
  include Pundit

  layout :default_layout

  def default_layout
    return "application_layout"
  end
end
