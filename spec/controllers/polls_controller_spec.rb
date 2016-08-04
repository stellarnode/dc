require 'rails_helper'

RSpec.describe PollsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Poll. As you add validations to Poll, be sure to
  # adjust the attributes here as well.
  #let (:user) {
  #  FactoryGirl.create(:user)
  #}
  login_user

  let(:valid_options) {
     ['opt1', 'opt2']
  }

  let(:valid_attributes) {
    { title: 'Superpoll', body: 'Superpoll', start: "2016-12-31 11:20:01", finish: "2016-12-31 11:20:03", 
      state: :opened, poll_type: 1, user_id: @user.id }
  }

  let(:invalid_attributes) {
    { title: nil, body: nil, start: nil, finish: nil, state: nil, poll_type: nil, user_id: @user.id }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PollsController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  describe "GET #index" do
    it "assigns all polls as @polls" do
      poll = Poll.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:polls)).to eq([poll])
    end
  end

  describe "GET #show" do
    it "assigns the requested poll as @poll" do
      poll = Poll.create! valid_attributes
      get :show, params: {id: poll.to_param}, session: valid_session
      expect(assigns(:poll)).to eq(poll)
    end
  end

  describe "GET #new" do
    it "assigns a new poll as @poll" do
      get :new, params: {}, session: valid_session
      expect(assigns(:poll)).to be_a_new(Poll)
    end
  end

  describe "GET #edit" do
    it "assigns the requested poll as @poll" do
      poll = Poll.create! valid_attributes
      get :edit, params: {id: poll.to_param}, session: valid_session
      expect(assigns(:poll)).to eq(poll)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Poll" do
        expect {
          post :create, params: {poll: valid_attributes}, session: valid_session
        }.to change(Poll, :count).by(1)
      end

      it "assigns a newly created poll as @poll" do
        post :create, params: {poll: valid_attributes}, session: valid_session
        expect(assigns(:poll)).to be_a(Poll)
        expect(assigns(:poll)).to be_persisted
      end

      it "redirects to the created poll" do
        post :create, params: {poll: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Poll.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved poll as @poll" do
        post :create, params: {poll: invalid_attributes}, session: valid_session
        expect(assigns(:poll)).to be_a_new(Poll)
      end

      it "re-renders the 'new' template" do
        post :create, params: {poll: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: 'Superpoll2', body: 'Superpoll2', start: "2016-07-11 11:20:03", finish: "2016-07-11 11:20:05", 
      state: :created, poll_type: 2, user_id: @user.id }
      }

      it "updates the requested poll" do
        poll = Poll.create! valid_attributes
        put :update, params: {id: poll.to_param, poll: new_attributes}, session: valid_session
        poll.reload
        expect(assigns(:poll)).to eq(poll)
      end

      it "assigns the requested poll as @poll" do
        poll = Poll.create! valid_attributes
        put :update, params: {id: poll.to_param, poll: valid_attributes}, session: valid_session
        expect(assigns(:poll)).to eq(poll)
      end

      it "redirects to the poll" do
        poll = Poll.create! valid_attributes
        put :update, params: {id: poll.to_param, poll: valid_attributes}, session: valid_session
        expect(response).to redirect_to(poll)
      end
    end

    context "with invalid params" do
      it "assigns the poll as @poll" do
        poll = Poll.create! valid_attributes
        put :update, params: {id: poll.to_param, poll: invalid_attributes}, session: valid_session
        expect(assigns(:poll)).to eq(poll)
      end

      it "re-renders the 'edit' template" do
        poll = Poll.create! valid_attributes
        put :update, params: {id: poll.to_param, poll: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested poll" do
      poll = Poll.create! valid_attributes
      expect {
        delete :destroy, params: {id: poll.to_param}, session: valid_session
      }.to change(Poll, :count).by(-1)
    end

    it "redirects to the polls list" do
      poll = Poll.create! valid_attributes
      delete :destroy, params: {id: poll.to_param}, session: valid_session
      expect(response).to redirect_to(polls_url)
    end
  end

end
