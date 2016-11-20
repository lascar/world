class WorldController < ApplicationController
  before_action :authenticate_user!, only: [:delete]
  def show
  end

  def delete
    if current_user.email == "god@heaven.com"
      render plain: "Apocalypse now"
    end
  end
end
