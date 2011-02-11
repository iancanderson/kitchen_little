require 'spec_helper'

describe RecipesController do

  describe "POST 'create'" do
    context "when successful" do
      before do
        @user = Factory(:user)
        @post_params = {  :link_url => "http://www.example.com/chili",
                          :link_name => "Delicious Chili" }
      end
      def post_recipe
        post :create,
             :recipe => @post_params,
             :user_id => @user.username
      end

      it "should redirect to the user show page" do
        post_recipe
        response.should redirect_to(@user)
      end
      it "should assign the recipe" do
        post_recipe
        assigns[:recipe].should_not be_nil
        assigns[:recipe].should be_kind_of(Recipe)
      end
      it "should create a record" do
        lambda {
          post_recipe
        }.should change(Recipe, :count).by(1)
      end
    end

    context "when failing" do
      before do
        @user = Factory(:user)
        @post_params = {  :link_url => "",
                          :link_name => "Delicious Chili" }
      end
      def post_recipe
        post :create,
             :recipe => @post_params,
             :user_id => @user.username
      end

      it "should re-render the user show page" do
        post_recipe
        response.should redirect_to(@user)
      end
      it 'assigns the recipe' do
        # This is important, so that when re-rendering "new", the previously entered values are already set
        post_recipe
        assigns[:recipe].should_not be_nil
        assigns[:recipe].should be_kind_of(Recipe)
      end
      it "should NOT create a record" do
        lambda {
          post_recipe
        }.should_not change(Recipe, :count)
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "when successful" do
      before do
        @recipe = Factory(:recipe)
      end
      it "should delete a record" do
        lambda {
          delete  :destroy,
                  :id => @recipe.id,
                  :user_id => @recipe.user.id
        }.should change(Recipe, :count).by(-1)
      end
    end
    context "when failing" do
      it "should NOT delete a record"
    end
  end
end
