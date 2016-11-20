require "rails_helper"

RSpec.describe WorldController, type: :routing do
  describe "routing" do
    it "routes to #delete" do
      expect(:delete => "/world").to route_to("world#delete")
    end
  end
end
