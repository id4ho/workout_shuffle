require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :require_admin_access

    def index
      render text: "hello"
    end
  end

  describe "#require_admin_access" do
    context "when signed in as an admin" do
      it "doesn't short circuit the requested action" do
        sign_in_as(create(:admin))
        get :index
        expect(response.body).to eq("hello")
      end
    end

    context "when signed in as a non-admin" do
      it "renders a 403" do
        sign_in_as(create(:user))
        get :index
        expect(response.status).to eq(403)
      end
    end
  end
end
