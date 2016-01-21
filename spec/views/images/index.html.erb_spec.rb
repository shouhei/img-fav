require 'spec_helper'

describe "images/index" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @image = FactoryGirl.create(:image)
    session[:user_id] = @user.id
    assign(:users, [@user])
    assign(:images, [@image])
  end
  describe "renders a list of images" do
    before(:each) do
      user01 = FactoryGirl.create(:user, name: "Hoge")
      user02 = FactoryGirl.create(:user, name: "Fuga")

      assign(:images, [
                        FactoryGirl.create(:image, user_id: user01.id , title: "Hogeimg"),
                        FactoryGirl.create(:image, user_id: user02.id , title: "Fugaimg")
                    ])
    end
    it "renders title of images" do
      render
      # Run the generator again with the --webrat flag if you want to use webrat matchers

      assert_select "tr>td", :text => "Hogeimg".to_s, :count => 1
      assert_select "tr>td", :text => "Fugaimg".to_s, :count => 1
    end
    it "renders users of images" do
      #後で
    end
  end
  it "renders favorite" do
    #assign(:favorites , [
    #                     FactoryGirl.create(:favorite, user: @user, image: @image)
    #                 ])
    #render
    #assert_select "tr>td", :text => "favorite".to_s, :count => 1
  end
end

