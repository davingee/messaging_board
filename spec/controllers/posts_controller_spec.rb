require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  context 'logged in' do 

    login_user #  @user is also available

    describe "GET #index" do
      it "assigns all posts as @posts" do
        post = FactoryGirl.create :post
        get :index, params: {}
        expect(assigns(:posts)).to eq([post])
      end
    end

    describe "GET #show" do
      it "assigns the requested post as @post" do
        post = FactoryGirl.create :post
        get :show, id: post.id
        expect(assigns(:post)).to eq(post)
      end
    end

    describe "GET #new" do
      it "assigns a new post as @post" do
        get :new, params: {}
        expect(assigns(:post)).to be_a_new(Post)
      end
    end

    describe "GET #edit" do
      it "assigns the requested post as @post" do
        post = FactoryGirl.create :post, author: @user
        get :edit, id: post.to_param
        expect(assigns(:post)).to eq(post)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Post" do
          expect {
            post :create, post: FactoryGirl.attributes_for(:post)
          }.to change(Post, :count).by(1)
        end

        it "assigns a newly created post as @post" do
          post :create, post: FactoryGirl.attributes_for(:post)
          expect(assigns(:post)).to be_a(Post)
          expect(assigns(:post)).to be_persisted
        end

        it "redirects to the created post" do
          post :create, post: FactoryGirl.attributes_for(:post)
          expect(response).to redirect_to(Post.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved post as @post" do
          post :create, post: FactoryGirl.attributes_for(:invalid_post)
          expect(assigns(:post)).to be_a_new(Post)
        end

        it "re-renders the 'new' template" do
          post :create, post: FactoryGirl.attributes_for(:invalid_post)
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {title: 'newbieish'}
        }

        it "updates the requested post" do
          post = FactoryGirl.create :post, author: @user
          put :update, id: post.id, post: new_attributes
          post.reload
          post.title.should eq('newbieish')
        end

        it "doesn't updates the requested post if the user didn't create it." do
          user = FactoryGirl.create :user
          post = FactoryGirl.create :post, author: user
          put :update, id: post.id, post: new_attributes
          post.reload
          post.title.should_not eq('newbieish')
        end

        it "assigns the requested post as @post" do
          post = FactoryGirl.create :post, author: @user
          put :update, id: post.id, post: new_attributes
          expect(assigns(:post)).to eq(post)
        end

        it "redirects to the post" do
          post = FactoryGirl.create :post, author: @user
          put :update, id: post.to_param, post: new_attributes
          expect(response).to redirect_to(post)
        end
      end

      context "with invalid params" do
        it "assigns the post as @post" do
          post = FactoryGirl.create :post, author: @user
          put :update, id: post.id, post: FactoryGirl.attributes_for(:invalid_post)
          expect(assigns(:post)).to eq(post)
        end

        it "re-renders the 'edit' template" do
          post = FactoryGirl.create :post, author: @user
          put :update, id: post.id, post: FactoryGirl.attributes_for(:invalid_post)
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested post" do
        post = FactoryGirl.create :post, author: @user
        expect {
          delete :destroy, id: post.id
        }.to change(Post, :count).by(-1)
      end

      it "redirects to the posts list" do
        post = FactoryGirl.create :post, author: @user
        delete :destroy, id: post.id
        expect(response).to redirect_to(posts_url)
      end

      it "does not delete if user doesn't own post" do 
        user = FactoryGirl.create :user
        post = FactoryGirl.create :post, author: user
        expect {
          delete :destroy, id: post.id
        }.to change(Post, :count).by(0)
      end
    end

  end


  context 'not logged in' do 

    describe "GET #index" do
      it "assigns all posts as @posts" do
        post = FactoryGirl.create :post
        get :index, params: {}
        expect(assigns(:posts)).to eq([post])
      end
    end

    describe "GET #show" do
      it "assigns the requested post as @post" do
        post = FactoryGirl.create :post
        get :show, id: post.id
        expect(assigns(:post)).to eq(post)
      end
    end

    describe "GET #new" do
      it "redirects to sign in path with flash message" do
        get :new, params: {}
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe "GET #edit" do
      it "redirects to sign in path with flash message" do
        user = FactoryGirl.create :user
        post = FactoryGirl.create :post, author: user
        get :edit, id: post.id
        expect(response).to redirect_to(new_user_session_url)
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "does not create a post" do
          expect {
            post :create, post: FactoryGirl.attributes_for(:post)
          }.to change(Post, :count).by(0)
        end

        it "redirects to sign in path with flash message" do
          post :create, post: FactoryGirl.attributes_for(:post)
          expect(response).to redirect_to(new_user_session_url)
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end

      end

    end

    describe "PUT #update" do

      let(:new_attributes){
        {
           title: 'newbieish' 
        }
      }

      let(:user){
        FactoryGirl.create :user
      }

      context "with valid params" do

        it "does not updates the requested post" do
          post = FactoryGirl.create :post, author: user
          put :update, id: post.id, post: new_attributes
          post.title_changed?.should eq false
        end

        it "redirects to root with flash message" do
          post = FactoryGirl.create :post, author: user
          put :update, id: post.id, post: new_attributes
          expect(response).to redirect_to(new_user_session_url)
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end

      end
    end

    describe "DELETE #destroy" do
      let(:user){
        FactoryGirl.create :user
      }
      it "does not destroys the requested post" do
        post = FactoryGirl.create :post, author: user
        expect {
          delete :destroy, id: post.id
        }.to change(Post, :count).by(0)
      end

      it "redirects to login page with flash message" do
        post = FactoryGirl.create :post, author: user
        delete :destroy, id: post.id
        expect(response).to redirect_to(new_user_session_url) # 
        expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
      end

    end

  end

end
