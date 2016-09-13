class PagesController < ApplicationController

  def accomodations
    login_required(redirect_path: accomodations_path)
  end

  def about
    login_required(redirect_path: about_path)
  end
end
