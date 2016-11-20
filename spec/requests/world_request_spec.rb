require 'rails_helper'

RSpec.describe WorldController, type: :request do

  describe "DELETE #delete" do
    describe "user is God" do
      before :each do
        @current_user = create(:user, email: 'god@heaven.com')
        login_as(@current_user, :scope => :user)
      end

      it "render a text 'Apocalypse now'" do
        delete '/world'
        expect(response.body).to eq('Apocalypse now')
      end
    end

    describe "user other than God" do
      before :each do
        @current_user = create(:user)
        login_as(@current_user, :scope => :user)
      end

      it "render a text 'Apocalypse now'" do
        delete '/world'
        expect(response.body).to eq('')
      end
    end

    describe "user not logged" do
      it "render a text 'Apocalypse now'" do
        delete '/world'
        expect(response.redirection?).to be(true)
      end
    end
  end
end
