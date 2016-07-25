require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  #let (:user) {
  #  FactoryGirl.create(:user)
  #}
  login_user

  let(:valid_attributes) {
    {first_name: 'John', last_name: 'Doe', middle_name: 'Paul', phone: '12345678', avatar: 'avatar', user_id: user.id }
  }

  let(:invalid_attributes) {
    {first_name: 1, last_name: 1, middle_name: 1, phone: 1, avatar: 1, user_id: 0 }
  }

  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :show, params: {:id => profile.to_param}, session: valid_session
      expect(assigns(:profile)).to eq(profile)
    end
  end

  describe "GET edit" do
    it "assigns the requested profile as @profile" do
      profile = Profile.create! valid_attributes
      get :edit, params: {:id => profile.to_param}, session: valid_session
      expect(assigns(:profile)).to eq(profile)
    end
  end
end
