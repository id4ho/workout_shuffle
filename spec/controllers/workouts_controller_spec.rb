require 'rails_helper'

RSpec.describe WorkoutsController, type: :controller do
  describe "before actions" do
    it { should use_before_action(:require_login) }
  end

  describe "GET #index" do
    it "assigns all the user's workouts to @workouts" do
      workout = create(:workout)
      sign_in_as(workout.user)

      get :index
      expect(assigns(:workouts)).to eq([workout])
    end
  end

  describe "GET #show" do
    before do
      @workout = create(:workout)
    end

    context "the workout belongs to the user" do
      it "assigns the requested workout as @workout" do
        sign_in_as(@workout.user)
        get :show, { id: @workout.to_param }
        expect(assigns(:workout)).to eq(@workout)
      end
    end

    context "the workout doesn't belong to the user" do
      it "renders head 403" do
        sign_in
        get :show, { id: @workout.to_param }
        expect(response.status).to eq(403)
      end
    end
  end

  describe "GET #new" do
    before do
      allow_any_instance_of(WorkoutsController).to receive(:workout_size)
        .and_return(1)

      @exercise1 = create(:exercise)
      @exercise2 = create(:exercise, name: "lunges")
      @exercise3 = create(:exercise, name: "curls")
      @cardio = create(:cardio_exercise)

      @workout = Workout.new
      @workout.exercises = [@exercise1, @exercise2, @exercise3, @cardio]

      expect(Workout).to receive(:generate_workout).with(4) { @workout }
    end

    it "assigns a freshly generated workout to @workout" do
      sign_in
      get :new
      expect(assigns(:workout)).to eq(@workout)
    end

    it "leaves the cardio exercise in the associated exercises" do
      sign_in
      get :new
      expect(assigns(:workout).exercises).to eq([@cardio])
    end

    it "assigns 3 of the returned exercises to @swaps" do
      sign_in
      get :new
      expect(assigns(:swaps)).to eq([@exercise1, @exercise2, @exercise3])
    end
  end

  describe "POST #create" do
    before do
      @exercise_ids = [create(:exercise).id, create(:cardio_exercise).id]
    end

    context "when the save is successful" do
      it "creates a new workout assigned to the current_user" do
        user = create(:user)
        sign_in_as(user)
        expect {
          post :create, { workout: { name: "new_workout" },
                          exercise_ids: @exercise_ids }
        }.to change(user.workouts, :count).by(1)
      end

      it "redirects via js to the new workout's path" do
        sign_in
        post :create, { workout: { name: "new_workout" },
                        exercise_ids: @exercise_ids }
        expect(response.content_type).to eq(Mime::JS)
        expect(response.body).to eq(
          "window.location = '#{ workout_path(Workout.last.to_param) }'"
        )
      end
    end

    context "when the save is successful" do
      it "renders the full error messages in json" do
        old_workout = create(:workout)
        sign_in_as(old_workout.user)
        post :create, { workout: { name: old_workout.name },
                        exercise_ids: @exercise_ids }
        expect(response.body).to match(/Name has already been taken/)
      end
    end
  end

  describe "DELETE #destroy" do
    before { @workout = create(:workout) }

    context "when the user owns the resource" do
      before { sign_in_as(@workout.user) }

      it "destroys the requested workout" do
        expect {
          delete :destroy, {id: @workout.to_param}
        }.to change(Workout, :count).by(-1)
      end

      it "redirects to the Workouts list" do
        delete :destroy, {id: @workout.to_param}
        expect(response).to redirect_to(workouts_url)
      end
    end

    context "when the user doesn't own the resource" do
      before { sign_in }

      it "renders head 403" do
        delete :destroy, {id: @workout.to_param}
        expect(response.status).to eq(403)
      end
    end
  end
end
