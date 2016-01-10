describe ImagesController do
  describe "GET index" do
    it "assigns all images as @images" do
      image = FactoryGirl.create(:image)
      get :index
      expect(assigns[:images]).to match_array([image])
    end
  end
  describe "GET show" do
    it "assigns the requested image as @image" do
      image = FactoryGirl.create(:image)
      get :show, id: image
      expect(assigns[:image]).to eq image
    end
  end
  context "user login" do
    before :each do
      @user = FactoryGirl.create(:user, name: "Fuga")
      session[:user_id] = @user.id
      @image = FactoryGirl.create(:image, user_id: @user.id)
    end
    describe "GET new" do
      it "assigns the new image as @image" do
        get :new
        expect(assigns[:image]).to be_a_new(Image)
      end
    end
    describe "GET edit" do
      it "assigns the requested user as @current_user" do
        get :edit, id: @image
        expect(assigns[:image].user_id).to eq session[:user_id]
      end
      it "assigns the requested user as no current_user" do
        #current_userじゃないidをgetするとredirectする
        @image = FactoryGirl.create(:image)
        get :edit, id: @image
        expect(response).to redirect_to image_path(assigns[:image])
      end
    end
    context "with valid value" do
      describe "POST create" do
        it "create new Image" do
          expect{
            post :create, image: FactoryGirl.attributes_for(:image)
          }.to change(Image, :count).by(1)
        end
      end
      describe "PUT update" do
        it "update my image" do
          image = FactoryGirl.create(:image,  user_id: @user.id)
          before_title = image.title
          put :update, id: image.id, image: FactoryGirl.attributes_for(:image, title:"new title")
          image.reload
          expect(before_title).to_not eq image.title
        end
        it "does not update other image" do
          image = FactoryGirl.create(:image)
          put :update, id: image.id, image: FactoryGirl.attributes_for(:image, title:"new title")
          expect(response).to redirect_to image_path(assigns[:image])
        end
      end
    end
    describe "DELETE destroy" do
      it "delete image" do
        image = FactoryGirl.create(:image)
        expect{
          delete :destroy, id: image
        }.to change(Image, :count).by(-1)
      end
    end
  end
  context "user logout" do
    describe "GET new" do
      it "redirect to login url" do
        get :new
        expect(response).to redirect_to sessions_login_url
      end
    end
    describe "POST create" do
      it "redirect to login url" do
        post :create, image: FactoryGirl.attributes_for(:image)
        expect(response).to redirect_to sessions_login_url
      end
    end
    describe "GET edit" do
      it "redirect to login url" do
        image = FactoryGirl.create(:image)
        get :edit, id: image.id
        expect(response).to redirect_to sessions_login_url
      end
    end
    describe "PUT update" do
      it "redirect to login url" do
        image = FactoryGirl.create(:image)
        put :update, id: image.id, image: FactoryGirl.attributes_for(:image)
        expect(response).to redirect_to sessions_login_url
      end
    end
    describe "DELETE destroy" do
      it "redirect to login url" do
        image = FactoryGirl.create(:image)
        delete :destroy, id: image.id
        expect(response).to redirect_to sessions_login_url
      end
    end
  end
end
