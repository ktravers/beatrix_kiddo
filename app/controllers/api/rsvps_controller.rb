class Api::RsvpsController < ApplicationController
  def update
    rsvp = Rsvp.find_by(id: rsvp_params[:id])
    # TODO

    # send confirmation email
  end

  private

  def rsvp_params
    params.permit(:id, :accepted, :declined)
  end
end
