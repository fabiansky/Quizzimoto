require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe QuizzesController do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuizzesController. Be sure to keep this updated too.
  def valid_session
    { :token => valid_login_token }
  end

  describe "GET index" do
    it "assigns all quizzes as @quizzes" do
      quiz = Factory :quiz
      get :index, {}, valid_session
      assigns(:quizzes).should eq([quiz])
    end
  end

  describe "GET show" do
    it "assigns the requested quiz as @quiz" do
      quiz = Factory :quiz
      get :show, {:id => quiz.to_param}, valid_session
      assigns(:quiz).should eq(quiz)
    end
  end

  describe "GET new" do
    it "assigns a new quiz as @quiz" do
      get :new, {}, valid_session
      assigns(:quiz).should be_a_new(Quiz)
    end
  end

  describe "GET edit" do
    it "assigns the requested quiz as @quiz" do
      quiz = Factory :quiz
      get :edit, {:id => quiz.to_param}, valid_session
      assigns(:quiz).should eq(quiz)
    end
  end

  describe "POST create" do
    before(:each) do
      stub_out_plus_discovery_document
      stub_out_current_user_profile
    end

    describe "with valid params" do
      it "creates a new Quiz" do
        expect {
          post :create, {:quiz => FactoryGirl.attributes_for(:quiz)}, valid_session
        }.to change(Quiz, :count).by(1)
      end

      it "assigns a newly created quiz as @quiz" do
        post :create, {:quiz => FactoryGirl.attributes_for(:quiz)}, valid_session
        assigns(:quiz).should be_a(Quiz)
        assigns(:quiz).should be_persisted
      end

      it "redirects to the created quiz" do
        post :create, {:quiz => FactoryGirl.attributes_for(:quiz)}, valid_session
        response.should redirect_to(Quiz.last)
      end

      it "uses the user's Google+ profile ID as the owner" do
        post :create, {:quiz => FactoryGirl.attributes_for(:quiz)}, valid_session
        Quiz.last.owner_id.should == '115478738847874567952'
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved quiz as @quiz" do
        # Trigger the behavior that occurs when invalid params are submitted
        Quiz.any_instance.stub(:save).and_return(false)
        post :create, {:quiz => {}}, valid_session
        assigns(:quiz).should be_a_new(Quiz)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Quiz.any_instance.stub(:save).and_return(false)
        post :create, {:quiz => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested quiz" do
        quiz = Factory :quiz
        # Assuming there are no other quizzes in the database, this
        # specifies that the Quiz created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Quiz.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => quiz.to_param, :quiz => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested quiz as @quiz" do
        quiz = Factory :quiz
        put :update, {:id => quiz.to_param, :quiz => FactoryGirl.attributes_for(:quiz)}, valid_session
        assigns(:quiz).should eq(quiz)
      end

      it "redirects to the quiz" do
        quiz = Factory :quiz
        put :update, {:id => quiz.to_param, :quiz => FactoryGirl.attributes_for(:quiz)}, valid_session
        response.should redirect_to(quiz)
      end
    end

    describe "with invalid params" do
      it "assigns the quiz as @quiz" do
        quiz = Factory :quiz
        # Trigger the behavior that occurs when invalid params are submitted
        Quiz.any_instance.stub(:save).and_return(false)
        put :update, {:id => quiz.to_param, :quiz => {}}, valid_session
        assigns(:quiz).should eq(quiz)
      end

      it "re-renders the 'edit' template" do
        quiz = Factory :quiz
        # Trigger the behavior that occurs when invalid params are submitted
        Quiz.any_instance.stub(:save).and_return(false)
        put :update, {:id => quiz.to_param, :quiz => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested quiz" do
      quiz = Factory :quiz
      expect {
        delete :destroy, {:id => quiz.to_param}, valid_session
      }.to change(Quiz, :count).by(-1)
    end

    it "redirects to the quizzes list" do
      quiz = Factory :quiz
      delete :destroy, {:id => quiz.to_param}, valid_session
      response.should redirect_to(quizzes_url)
    end
  end

end
