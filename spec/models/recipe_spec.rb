require 'spec_helper'

describe Recipe do

  it "belongs to a user" do
    should respond_to(:user)
  end

  context "is not valid" do
    [:link_url, :link_name].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end
    it "with a blank link_url" do
      subject.link_url = "  "
      subject.should_not be_valid
      subject.errors[:link_url].should_not be_empty
    end
    it "with a blank link_name" do
      subject.link_name = "  "
      subject.should_not be_valid
      subject.errors[:link_name].should_not be_empty
    end

    context "with a duplicate" do
      before(:each) do
        @recipe1 = Factory.create(:recipe)
      end
      
      it "link_name and the same user_id" do
        lambda{
          Factory.create(:recipe,
                         :link_name => @recipe1.link_name,
                         :user_id => @recipe1.user_id)
        }.should raise_error(ActiveRecord::RecordInvalid, /already been taken/)
      end

      it "link_url and the same user_id" do
        lambda{
          Factory.create(:recipe,
                         :link_url => @recipe1.link_url,
                         :user_id => @recipe1.user_id)
        }.should raise_error(ActiveRecord::RecordInvalid, /already been taken/)
      end
    end
  end

  context "scopes" do
    before do
      Recipe.delete_all
      @first_recipe = Factory.create(:recipe, :created_at => 1.day.ago)
      @second_recipe = Factory.create(:recipe, :created_at => 1.hour.ago)
    end

    it "is ordered by descending creation date, by default" do
      Recipe.all.should == [@second_recipe, @first_recipe]
    end
  end
end
