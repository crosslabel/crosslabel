require 'rails_helper'

RSpec.describe Api::V1::ProductsController, :type => :controller do
  describe "GET #show" do
    before(:each) do
      @product = FactoryGirl.create :product
      get :show, id: @product.id
    end

    it "returns the information about a product on a hash" do
      product_response = json_response[:product]
      expect(product_response[:title]).to eq @product.title
    end

    it { should respond_with 200}
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :product}
      get :index
    end

    it "returns 4 records from the database" do
      product_response = json_response[:products]
      expect(product_response.length).to eq(4)
    end

    it { should respond_with 200}
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @product_attributes = FactoryGirl.attributes_for :product
        api_authorization_header user.auth_token
        post :create, product: @product_attributes
      end

      it "renders the json representation of the product record jsut created" do
        product_response = json_response[:product]
        expect(product_response[:title]).to eql @product_attributes[:title]
      end

      it { should respond_with 201}
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_product_attributes = { title: 'Smart TV', price: 'twelve dollars'}
        api_authorization_header user.auth_token
        post :create, product: @invalid_product_attributes
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the product could not be created" do
        product_response = json_response
        expect(product_response[:errors][:unit_price]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: @product.id, product: { title: 'An expensive TV' } }
      end

      it "renders the json representation for the updated user" do
        product_response = json_response[:product]
        expect(product_response[:title]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { id: @product.id, product: { unit_price: "" } }
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        product_response = json_response
        expect(product_response[:errors][:unit_price]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end

  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product
      api_authorization_header @user.auth_token
      delete :destroy, { id: @product.id }
    end

    it { should respond_with 204 }
  end
end
