require 'spec_helper'

describe Ingredient do

  it "belongs to user" do
    should respond_to(:user)
  end

  context "is not valid" do
    [:name, :user_id].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end

    it "with a blank name" do
      subject.name = "  "
      subject.should_not be_valid
      subject.errors[:name].should_not be_empty
    end

    it "with a name longer than 50 characters" do
      subject.name = "a"*51;
      subject.should_not be_valid
      subject.errors[:name].should_not be_empty
    end

    it "with a duplicate name and the same user_id" do
      ingredient1 = Factory.create(:ingredient)
      lambda {
        ingredient2 = Factory.create(:ingredient,
                                     :name => ingredient1.name,
                                     :user_id => ingredient1.user_id)
      }.should raise_error(ActiveRecord::RecordInvalid, /already been taken/)
    end
  end

  context "scopes" do
    before do
      Ingredient.delete_all
      @first_ingredient = Factory(:ingredient, :created_at => 1.day.ago)
      @second_ingredient = Factory(:ingredient, :created_at => 1.hour.ago)
    end

    it "is ordered by descending creation date, by default" do
      Ingredient.all.should == [@second_ingredient, @first_ingredient]
    end
  end
end
