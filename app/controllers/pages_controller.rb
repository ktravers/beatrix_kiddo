class PagesController < ApplicationController

  def accomodations
    login_required(redirect_path: accomodations_path)
  end
end
