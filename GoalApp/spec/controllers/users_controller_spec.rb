require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    before(:each) {get :new}
    it "returns http success" do
      # get :new
      expect(response).to have_http_status(:success)
    end

    it "renders new user page" do
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    # it "returns http success" do
    #   post :create, params: { user: { username: 'bob', password: 'password' } }
    #   expect(response).to have_http_status(:success)
    # end

    context 'if valid login credentials' do
      it 'redirects to goals index page' do
        post :create, params: { user: { username: 'bob', password: 'password' } }
        expect(response).to redirect_to(goals_url)
      end
    end

    context 'if invalid login credentials' do
      before(:each) { post :create, params: { user: { username: 'bob', password: 'p' } } }

      it 're-renders new user page' do
        expect(response).to render_template(:new)
      end

      it 'logs errors' do
        expect(flash[:errors]).to be_present
      end
    end
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
