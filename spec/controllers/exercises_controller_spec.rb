require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  let(:invalid_attributes) { { name: "ab" } }
  let(:valid_attributes) { { name: "new exercise name" } }

  describe "before actions" do
    # Shoulda matchers just checks the existance of the before_action not
    # which actions are actually filtered. This is kind of a limitation
    # There is an old PR to fix it.. but doesn't look like it'll be merged
    # https://github.com/thoughtbot/shoulda-matchers/pull/727
    it { should use_before_action(:require_login) }
    it { should use_before_action(:require_admin_access) }
  end

  describe "GET #index" do
    it "assigns all exercises as @exercises" do
      exercise = create(:exercise)
      get :index, {}
      expect(assigns(:exercises)).to eq([exercise])
    end
  end

  describe "GET #show" do
    it "assigns the requested exercise as @exercise" do
      exercise = create(:exercise)
      get :show, {id: exercise.to_param}
      expect(assigns(:exercise)).to eq(exercise)
    end
  end

  describe "GET #new" do
    context "when signed in as an admin" do
      it "assigns a new exercise as @exercise" do
        sign_in_as(create(:admin))
        get :new, {}
        expect(assigns(:exercise)).to be_a_new(Exercise)
      end
    end

    context "when signed in as a non-admin" do
      it "responds with a 403" do
        sign_in
        get :new, {}
        expect(response.code).to eq("403")
      end
    end

    context "when not signed in" do
      it "redirects to the sign in path" do
        get :new, {}
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "GET #edit" do
    before { @exercise = create(:exercise) }

    context "when signed in as an admin" do
      it "assigns the requested exercise as @exercise" do
        sign_in_as(create(:admin))
        get :edit, {id: @exercise.to_param}
        expect(assigns(:exercise)).to eq(@exercise)
      end
    end

    context "when signed in as a non-admin" do
      it "responds with a 403" do
        sign_in
        get :edit, {id: @exercise.to_param}
        expect(response.code).to eq("403")
      end
    end

    context "when not signed in" do
      it "redirects to the sign in path" do
        get :edit, {id: @exercise.to_param}
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      context "when signed in as an admin" do
        before { sign_in_as(create(:admin)) }

        it "creates a new Exercise" do
          expect {
            post :create, {exercise: valid_attributes}
          }.to change(Exercise, :count).by(1)
        end

        it "assigns a newly created exercise as @exercise" do
          post :create, {exercise: valid_attributes}
          expect(assigns(:exercise)).to be_a(Exercise)
          expect(assigns(:exercise)).to be_persisted
        end

        it "redirects to the created exercise" do
          post :create, {exercise: valid_attributes}
          expect(response).to redirect_to(exercise_path(Exercise.last.id))
        end
      end

      context "when sign in as a non-admin" do
        it "responds with a 403" do
          sign_in
          post :create, {exercise: valid_attributes}
          expect(response.code).to eq("403")
        end
      end

      context "when not signed in" do
        it "redirects to the sign in path" do
          post :create, {exercise: valid_attributes}
          expect(response).to redirect_to(sign_in_path)
        end
      end
    end

    context "with valid params and a primary muscle target" do
      let(:primary_muscle_group) { create(:muscle_group) }
      let(:valid_attributes) do
        {
          name: "Curls",
          primary_muscle_group: { id: primary_muscle_group.to_param }
        }
      end

      it "creates a new Exercise and MuscleTarget" do
        sign_in_as(create(:admin))
        expect {
          post :create, {exercise: valid_attributes}
        }.to change(Exercise, :count).by(1)
        expect(Exercise.last.primary_muscle_group).to eq(primary_muscle_group)
      end
    end

    context "with invalid params" do
      before { sign_in_as(create(:admin)) }

      it "assigns a newly created but unsaved exercise as @exercise" do
        post :create, {exercise: invalid_attributes}
        expect(assigns(:exercise)).to be_a_new(Exercise)
      end

      it "re-renders the 'new' template" do
        post :create, {exercise: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before { @exercise = create(:exercise) }

    context "with valid params" do
      let(:new_attributes) { { name: "super curls" } }

      context "when signed in as an admin" do
        before { sign_in_as(create(:admin)) }

        it "updates the requested exercise" do
          put :update, {id: @exercise.to_param, exercise: new_attributes}
          @exercise.reload
          expect(@exercise.name).to eq("super curls")
        end

        it "assigns the requested exercise as @exercise" do
          put :update, {id: @exercise.to_param, exercise: valid_attributes}
          expect(assigns(:exercise)).to eq(@exercise)
        end

        it "redirects to the exercise" do
          put :update, {id: @exercise.to_param, exercise: valid_attributes}
          expect(response).to redirect_to(@exercise)
        end
      end

      context "when sign in as a non-admin" do
        it "responds with a 403" do
          sign_in
          put :update, {id: @exercise.to_param, exercise: valid_attributes}
          expect(response.code).to eq("403")
        end
      end

      context "when not signed in" do
        it "redirects to the sign in path" do
          put :update, {id: @exercise.to_param, exercise: valid_attributes}
          expect(response).to redirect_to(sign_in_path)
        end
      end
    end

    context "with invalid params" do
      before { sign_in_as(create(:admin)) }

      it "assigns the exercise as @exercise" do
        put :update, {id: @exercise.to_param, exercise: invalid_attributes}
        expect(assigns(:exercise)).to eq(@exercise)
      end

      it "re-renders the 'edit' template" do
        put :update, {id: @exercise.to_param, exercise: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before { @exercise = create(:exercise) }

    context "when signed in as an admin" do
      before { sign_in_as(create(:admin)) }

      it "destroys the requested exercise" do
        expect {
          delete :destroy, {id: @exercise.to_param}
        }.to change(Exercise, :count).by(-1)
      end

      it "redirects to the exercises list" do
        delete :destroy, {id: @exercise.to_param}
        expect(response).to redirect_to(exercises_url)
      end
    end

    context "when signed in as a non-admin" do
      it "responds with a 403" do
        sign_in
        delete :destroy, {id: @exercise.to_param}
        expect(response.code).to eq("403")
      end
    end

    context "when not signed in" do
      it "redirects to the sign in path" do
        delete :destroy, {id: @exercise.to_param}
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
