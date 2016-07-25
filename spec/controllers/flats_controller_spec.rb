require 'rails_helper'

RSpec.describe FlatsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Flat. As you add validations to Flat, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {number: 1, floor: 1, entrance: 1}
  }

  let(:invalid_attributes) {
    {number: nil, floor: nil, entrance: nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FlatsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all flats as @flats" do
      flat = Flat.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:flats)).to eq([flat])
    end
  end

  describe "GET #show" do
    it "assigns the requested flat as @flat" do
      flat = Flat.create! valid_attributes
      get :show, params: {:id => flat.to_param}, session: valid_session
      expect(assigns(:flat)).to eq(flat)
    end
  end

  describe "GET #new" do
    it "assigns a new flat as @flat" do
      get :new, params: {}, session: valid_session
      expect(assigns(:flat)).to be_a_new(Flat)
    end
  end

  describe "GET #edit" do
    it "assigns the requested flat as @flat" do
      flat = Flat.create! valid_attributes
      get :edit, params: {:id => flat.to_param}, session: valid_session
      expect(assigns(:flat)).to eq(flat)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Flat" do
        expect {
          post :create, params: {:flat => valid_attributes}, session: valid_session
        }.to change(Flat, :count).by(1)
      end

      it "assigns a newly created flat as @flat" do
        post :create, params: {:flat => valid_attributes}, session: valid_session
        expect(assigns(:flat)).to be_a(Flat)
        expect(assigns(:flat)).to be_persisted
      end

      it "redirects to the created flat" do
        post :create, params: {:flat => valid_attributes}, session: valid_session
        expect(response).to redirect_to(Flat.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved flat as @flat" do
        post :create, params: {:flat => invalid_attributes}, session: valid_session
        expect(assigns(:flat)).to be_a_new(Flat)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:flat => invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {number: 3, floor: 4, entrance: 2}
      }

      it "updates the requested flat" do
        flat = Flat.create! valid_attributes
        put :update, params: {:id => flat.to_param, :flat => new_attributes}, session: valid_session
        flat.reload
        expect(flat.number).to eq(3)
        expect(flat.floor).to eq(4)
        expect(flat.entrance).to eq(2)

      end

      it "assigns the requested flat as @flat" do
        flat = Flat.create! valid_attributes
        put :update, params: {:id => flat.to_param, :flat => valid_attributes}, session: valid_session
        expect(assigns(:flat)).to eq(flat)
      end

      it "redirects to the flat" do
        flat = Flat.create! valid_attributes
        put :update, params: {:id => flat.to_param, :flat => valid_attributes}, session: valid_session
        expect(response).to redirect_to(flat)
      end
    end

    context "with invalid params" do
      it "assigns the flat as @flat" do
        flat = Flat.create! valid_attributes
        put :update, params: {:id => flat.to_param, :flat => invalid_attributes}, session: valid_session
        expect(assigns(:flat)).to eq(flat)
      end

      it "re-renders the 'edit' template" do
        flat = Flat.create! valid_attributes
        put :update, params: {:id => flat.to_param, :flat => invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested flat" do
      flat = Flat.create! valid_attributes
      expect {
        delete :destroy, params: {:id => flat.to_param}, session: valid_session
      }.to change(Flat, :count).by(-1)
    end

    it "redirects to the flats list" do
      flat = Flat.create! valid_attributes
      delete :destroy, params: {:id => flat.to_param}, session: valid_session
      expect(response).to redirect_to(flats_url)
    end
  end

end
