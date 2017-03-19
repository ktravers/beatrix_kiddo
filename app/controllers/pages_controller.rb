class PagesController < ApplicationController

  def about
    login_required(redirect_path: about_path)
  end

  def accomodations
    login_required(redirect_path: accomodations_path)
  end

  def registry
    login_required(redirect_path: registry_path)
  end

  def trivia
    login_required(redirect_path: trivia_path)
  end
end
