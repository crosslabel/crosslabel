require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { FactoryGirl.create(:category)}

  describe "GET #index" do
    context "visiting index page" do
      it "returns the index view" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #show" do
    context "visiting show page" do
      it "returns the index view" do
        get :show, title: category.title
        expect(response).to render_template(:show)
      end
    end
  end
end
